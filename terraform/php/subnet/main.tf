resource "aws_subnet" "subnet_one" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_subnet
  availability_zone = var.subnet_zone

  tags = {
    Name = var.sub_name
  }

}