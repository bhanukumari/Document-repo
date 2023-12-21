resource "aws_vpc" "vpc_one" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc
  }

}
