resource "aws_route_table_association" "rta" {
  subnet_id      = var.sub_id
  route_table_id = var.pubtable_id
}