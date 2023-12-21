resource "aws_network_acl" "nacl" {
  vpc_id = var.vpcid
  ingress {
    rule_no     = 100
    from_port   = 22
    to_port     = 22
    protocol    = "0"
    action      = "allow"
    cidr_block  = var.cidr_blocks
  }

  egress {
    rule_no     = 100
    from_port   = 22
    to_port     = 22
    protocol    = "0"
    action =   "allow"
    cidr_block  = var.cidr_blocks
  }
}
