resource "aws_subnet" "private-sub" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.private-az_zone[count.index]

  tags = {
    Name = var.private-subnet-name[count.index]
  }
}