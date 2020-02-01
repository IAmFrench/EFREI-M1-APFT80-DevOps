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


