resource "tls_private_key" "zomboid_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "zomboid"
  public_key = tls_private_key.zomboid_key.public_key_openssh
  tags = {
    Name = "pz-server"
  }
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

  root_block_device {
    volume_size = 25 # Set root volume to 25GB (Optional, if you want to expand root disk)
    volume_type = "gp3"
  }


#   user_data            = <<EOF
# #!/bin/bash
# cd /home/pzuser/pzserver
# rm Zomboid.tar.gz Zomboid -rf
# aws s3 cp s3://${var.bucket_name}/Zomboid.tar.gz . && tar -xf Zomboid.tar.gz
# sudo -u pzuser bash -c 'cd /home/pzuser && source .profile && start-zomboid && screen -r'
# EOF

  tags = {
    Name = "pz-server"
  }



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
sudo -u pzuser bash -c 'cd /home/pzuser && source .profile && start-zomboid && screen -r'
EOF
  tags = {
    Name = "pz-server"
  }

}
