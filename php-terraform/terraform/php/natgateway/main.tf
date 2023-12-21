
resource "aws_eip" "elasticip" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = var.sub_id

  tags = {
    Name = "ninja-nat-01"
  }
}