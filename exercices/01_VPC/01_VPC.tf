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


resource "aws_route_table" "Custom_Route_table" {
  vpc_id = aws_vpc.vpc_tp.id
  
  # Note that the default route, mapping the VPC's CIDR block to "local", 
  # is created implicitly and cannot be specified.
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Custom_Route_table"
  }
}

resource "aws_route_table" "Main_Route_Table" {
  vpc_id = aws_vpc.vpc_tp.id
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.Nat_Jump.id
  }
  tags = {
    Name = "Main_Route_Table"
  }
}


resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.sub_pub.id
  route_table_id = aws_route_table.Custom_Route_table.id
}
resource "aws_route_table_association" "priv" {
  subnet_id      = aws_subnet.sub_priv.id
  route_table_id = aws_route_table.Main_Route_Table.id
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.102.224.0/24"] # EFREI Public IPs see https://bgp.he.net/net/192.102.224.0/24
  }

  tags = {
    Name = "allow_all"
  }
}

resource "aws_security_group" "Priv" {
  name        = "Priv"
  description = "Allow All inbound/outbound traffic from Public subnet"
  vpc_id      = aws_vpc.vpc_tp.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.sub_pub.cidr_block] # Allow incoming traffic from the Public subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.sub_pub.cidr_block] # Allow incoming traffic from the Public subnet
  }

  tags = {
    Name = "allow_all"
  }
}


resource "aws_instance" "Nat_Jump" {
  ami = "ami-035966e8adab4aaad" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  associate_public_ip_address = true

  subnet_id = aws_subnet.sub_pub.id # The public subnet Id 
  user_data = file("01_EC2_user-data_Nat-Jump.sh")

  key_name = aws_key_pair.rufol.key_name
  source_dest_check = false

  tags = {
    Name = "Nat_JumpHost"
  }

  vpc_security_group_ids = [aws_security_group.Nat_Jump.id]
}


resource "aws_instance" "Test_Instance" {
  ami = "ami-035966e8adab4aaad" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  associate_public_ip_address = true

  subnet_id = aws_subnet.sub_priv.id # The private subnet Id 
  user_data = file("01_EC2_user-data_Test-Instance.sh")

  key_name = aws_key_pair.rufol.key_name
  source_dest_check = false

  tags = {
    Name = "Test_Instance"
  }

  vpc_security_group_ids = [aws_security_group.Priv.id]
}


resource "aws_key_pair" "rufol" {
  key_name   = "rufol"
  public_key = file("01_rufol.pub")
}
