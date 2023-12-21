output "privatesub_id" {
    description = "pvt subnet id for instance"
    value = aws_subnet.private-sub[*].id
}