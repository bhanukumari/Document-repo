resource "aws_instance" "server" {
  # instance_type = var.instance_type[count.index]
  instance_type               = lookup(var.static, "itype")
  subnet_id                   = var.sub_id
  ami                         = lookup(var.static, "ami")
  associate_public_ip_address = lookup(var.static, "publicip")
  key_name                    = lookup(var.static, "keyname")
  vpc_security_group_ids      = [var.security_id]

  tags = {
    Name = var.public_name
  }
}