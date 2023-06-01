resource "aws_security_group" "ingress-ssh-vps" {
  name   = "allow-ssh-sg"
  vpc_id = aws_vpc.vps-env.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-pz-server-vps" {
  name   = "allow-pz-server-ports"
  vpc_id = aws_vpc.vps-env.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 16262
    to_port   = 16262
    protocol  = "udp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 16261
    to_port   = 16261
    protocol  = "udp"
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 27015
    to_port   = 27015
    protocol  = "tcp"
  }

  egress {
    from_port   = 27015
    to_port     = 27015
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 16262
    to_port     = 16262
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 16261
    to_port     = 16261
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
