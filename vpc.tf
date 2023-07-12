resource "aws_vpc" "vps-env" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "pz-server"
  }
}

resource "aws_subnet" "subnet-one" {
  # creates a subnet
  cidr_block              = cidrsubnet(aws_vpc.vps-env.cidr_block, 3, 1)
  vpc_id                  = aws_vpc.vps-env.id
  availability_zone       = var.aws_availability_zone
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "vps-env-gw" {
  vpc_id = aws_vpc.vps-env.id
}

resource "aws_route_table" "route-table-vps-env" {
  vpc_id = aws_vpc.vps-env.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vps-env-gw.id
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-one.id
  route_table_id = aws_route_table.route-table-vps-env.id
}

resource "aws_vpc_endpoint" "vpc_endpoint_gw" {
  vpc_id          = aws_vpc.vps-env.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = ["${aws_route_table.route-table-vps-env.id}"]
}
