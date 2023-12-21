resource "aws_instance" "server1" {
  count                       = length(var.private_name)
  instance_type               = lookup(var.static, "itype")
  subnet_id                   = var.privatesub_id[count.index]
  ami                         = lookup(var.static, "ami")
  associate_public_ip_address = lookup(var.static, "publicip")
  key_name                    = lookup(var.static, "keyname")
  vpc_security_group_ids      = [var.security_id]

  tags = {
    Name = var.private_name[count.index]
  }
}
