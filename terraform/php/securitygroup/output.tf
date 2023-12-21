output "security_id" {
  description = "sg id for instance"
  value = aws_security_group.allow_tls.id
}