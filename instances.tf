resource "tls_private_key" "zomboid_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "zomboid"
  public_key = tls_private_key.zomboid_key.public_key_openssh
}

resource "aws_spot_instance_request" "pz-spot" {
  ami           = var.instance_ami
  spot_price    = var.spot_price
  instance_type = var.instance_type
  spot_type     = var.spot_type
  # block_duration_minutes = 120
  wait_for_fulfillment = "true"
  key_name             = aws_key_pair.ssh_key.key_name
  count                = var.spot_instance == "true" ? 1 : 0

  security_groups      = ["${aws_security_group.ingress-ssh-vps.id}", "${aws_security_group.ingress-pz-server-vps.id}"]
  subnet_id            = aws_subnet.subnet-one.id
  iam_instance_profile = aws_iam_instance_profile.pz-profile.name
  user_data            = <<EOF
#!/bin/bash
cd /home/pzuser/pzserver
rm Zomboid.tar.gz Zomboid -rf
aws s3 cp s3://${var.bucket_name}/Zomboid.tar.gz . && tar -xf Zomboid.tar.gz
EOF

 /*  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.zomboid_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo su pzuser",
      "cd /home/pzuser",
      "source .profile && start-zomboid && screen -r",
    ]
  } */
}

resource "aws_instance" "pz-server" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ssh_key.key_name
  subnet_id              = aws_subnet.subnet-one.id
  vpc_security_group_ids = ["${aws_security_group.ingress-ssh-vps.id}", "${aws_security_group.ingress-pz-server-vps.id}"]
  count                  = var.spot_instance == "true" ? 0 : 1
  iam_instance_profile   = aws_iam_instance_profile.pz-profile.name
  user_data              = <<EOF
#!/bin/bash
cd /home/pzuser/pzserver
rm Zomboid.tar.gz Zomboid -rf
aws s3 cp s3://${var.bucket_name}/Zomboid.tar.gz . && tar -xf Zomboid.tar.gz
EOF
}
