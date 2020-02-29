resource "aws_vpc" "vpc_tp" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "TP_CICD"
  }
  enable_dns_hostnames = true
}


resource "aws_subnet" "sub_pub" {
  vpc_id            = aws_vpc.vpc_tp.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "TP_CICD_Public"
  }
}


resource "aws_subnet" "sub_priv" {
  vpc_id            = aws_vpc.vpc_tp.id
  cidr_block        = "172.16.2.0/24"
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

# The Custom Route table is attached to the Public subnet
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
# Attach the Custom route table to the Public subnet
resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.sub_pub.id
  route_table_id = aws_route_table.Custom_Route_table.id
}

resource "aws_security_group" "SSH" {
  name        = "SSH"
  description = "Allow Only SSH inbound traffic from EFREI & our Homes network"
  vpc_id      = aws_vpc.vpc_tp.id

  ingress {
    from_port = 22 # only SSH
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "192.102.224.0/24",            # EFREI & home Public IPs see https://bgp.he.net/net/192.102.224.0/24
      "46.193.4.20/32",              # Home network
      "82.64.104.10/32",             # Home2  network
      aws_subnet.sub_priv.cidr_block # The Private subnet
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all egress traffic
  }

  tags = {
    Name = "SSH"
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
    cidr_blocks = [aws_subnet.sub_pub.cidr_block] # Allow all incoming traffic from the Public subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outgoing traffic
  }

  tags = {
    Name = "allow_all from public subnet"
  }
}

# This is our BASTION Instance in the Public subnet, we will use this instance to establish an ssh session to
# the test instance in the private subnet
resource "aws_instance" "ToolsCICD" {
  ami           = "ami-035966e8adab4aaad" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  associate_public_ip_address = true # We ask for a public IP

  subnet_id = aws_subnet.sub_pub.id # The public subnet Id 
  user_data = file(var.ec2_startup_script)

  key_name          = aws_key_pair.rufol.key_name
  source_dest_check = false # Default true, but because we use this instance as a NAT we have to disable it

  tags = {
    Name = "ToolsCICD"
  }

  vpc_security_group_ids = [aws_security_group.SSH.id]
}

variable "ec2_startup_script" {
  type = string
}

resource "aws_instance" "RemoteServer" {
  ami           = "ami-035966e8adab4aaad" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  associate_public_ip_address = true # We ask for a public IP

  subnet_id = aws_subnet.sub_pub.id # The public subnet Id

  key_name          = aws_key_pair.rufol.key_name
  source_dest_check = false # Default true, but because we use this instance as a NAT we have to disable it

  tags = {
    Name = "RemoteServer"
  }

  vpc_security_group_ids = [aws_security_group.SSH.id]
}


resource "aws_key_pair" "rufol" {
  key_name   = "rufol"
  public_key = file(var.pubKeyPath)
}

variable "pubKeyPath" {
  type = string
}


output "ToolsCICD-instance" {
  value = aws_instance.ToolsCICD.public_dns
}

output "RemoteServer-instance" {
  value = aws_instance.RemoteServer.public_dns
}