resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name    = "vpc-ansible"
    Project = "Ansible"
  }
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  depends_on = [
    aws_vpc.vpc
  ]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true
  tags = {
    Name    = "public-subnet"
    Project = "Ansible"
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [
    aws_vpc.vpc
  ]
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "internet-gatway"
    Project = "Ansible"
  }
}


resource "aws_route_table" "IG_route_table" {
  depends_on = [
    aws_vpc.vpc
  ]
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name    = "IG-route-table"
    Project = "Ansible"
  }
}


resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on = [
    aws_subnet.public_subnet,
    aws_route_table.IG_route_table
  ]
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.IG_route_table.id
}



