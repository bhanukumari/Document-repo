# creating security group
resource "aws_security_group" "allow_tls" {
  vpc_id = var.vpc_id
  name        = var.name-sg
  description = "Allow TLS inbound traffic"
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_blocks]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.cidr_blocks]
    ipv6_cidr_blocks = ["::/0"]
  }
}