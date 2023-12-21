resource "aws_route_table_association" "rta2" {
  count          = length(var.privatesub_id)
  subnet_id      = var.privatesub_id[count.index]
  route_table_id = var.rt_id
}