resource "aws_instance" "web" {
  ami                    = "ami-051ebe9615b416c15"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0a24e420760b6d577"]
  tags = {
    Name = "terraform - webInstance"
  }
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow inbound traffic"
}

resource "aws_security_group_rule" "web-egress_allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_web.id
}

resource "aws_security_group_rule" "ingress_allow_web" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["192.102.224.0/24"]
  security_group_id = aws_security_group.allow_web.id
}
