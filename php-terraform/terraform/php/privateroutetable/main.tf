resource "aws_route_table" "ngw-rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "nat-gw-rt"
  }
}
resource "aws_route" "r2" {
  route_table_id         = aws_route_table.ngw-rt.id
  destination_cidr_block = var.rt_cidr
  gateway_id             = var.natgate_id
  
}


# resource "aws_route_table_association" "rta2" {
#   subnet_id      = var.privatesub_id 
#   route_table_id = aws_route_table.ngw-rt.id
# }