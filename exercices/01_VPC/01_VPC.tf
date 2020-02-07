provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-1"
}


resource "aws_vpc" "vpc_tp" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "TP_CICD"
  }
  enable_dns_hostnames = true
}


resource "aws_subnet" "sub_pub" {
  vpc_id     = aws_vpc.vpc_tp.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "TP_CICD_Public"
  }
}


resource "aws_subnet" "sub_priv" {
  vpc_id     = aws_vpc.vpc_tp.id
  cidr_block = "172.16.2.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "TP_CICD_Private"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_tp.id

  tags = {
    Name = "TP_CICD_IGW"
  }
}


resource "aws_route_table" "r" {
  vpc_id = aws_vpc.vpc_tp.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "TP_CICD_Default"
  }
}


resource "aws_security_group" "Nat_Jump" {
  name        = "Nat_Jump"
  description = "Allow All inbound traffic from EFREI network"
  vpc_id      = aws_vpc.vpc_tp.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.102.224.0/24"] # EFREI Public IPs see https://bgp.he.net/net/192.102.224.0/24
  }

  tags = {
    Name = "allow_all"
  }
}


resource "aws_instance" "ubuntu" {
  ami = "ami-035966e8adab4aaad"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  subnet_id = aws_subnet.sub_pub.id
  user_data = file("01_EC2_user-data.sh")

  tags = {
    Name = "Nat_JumpHost"
  }

  vpc_security_group_ids = [aws_security_group.Nat_Jump.id]
}
