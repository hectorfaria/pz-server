

resource "aws_eip_association" "ip-vps-env" {
  instance_id   = var.spot_instance == "true" ? "${aws_spot_instance_request.vps[0].spot_instance_id}" : "${aws_instance.pz-server[0].id}"
  allocation_id = var.allocated_id
}


resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file(var.ssh_pub_path)
}

resource "aws_spot_instance_request" "vps" {
  ami           = var.instance_ami
  spot_price    = var.spot_price
  instance_type = var.instance_type
  spot_type     = var.spot_type
  # block_duration_minutes = 120
  wait_for_fulfillment = "true"
  key_name             = aws_key_pair.ssh_key.key_name
  count                = var.spot_instance == "true" ? 1 : 0

  security_groups = ["${aws_security_group.ingress-ssh-vps.id}", "${aws_security_group.ingress-pz-server-vps.id}"]
  subnet_id       = aws_subnet.subnet-one.id
}

resource "aws_instance" "pz-server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.subnet-one.id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.ingress-ssh-vps.id}", "${aws_security_group.ingress-pz-server-vps.id}"]
  count                       = var.spot_instance == "true" ? 0 : 1
}
