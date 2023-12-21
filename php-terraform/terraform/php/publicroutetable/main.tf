resource "aws_route_table" "route-table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "ninja-route-pub-01"
  }
}
resource "aws_route" "rt" {
  route_table_id         = aws_route_table.route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.intnet_gateway_id
}

# resource "aws_route_table_association" "rta" {
#   subnet_id      = var.sub_id
#   route_table_id = aws_route_table.route-table.id
# }