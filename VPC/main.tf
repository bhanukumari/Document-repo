resource "aws_vpc" "main" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_flow_log" "vpc_flow_logs" {
  count = var.enable_vpc_logs == true ? 1 : 0
  log_destination      = var.vpc_logs_bucket_ARN
  log_destination_type = var.log_destination_type
  traffic_type         = var.traffic_type
  vpc_id               = aws_vpc.main.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = format("%s-igw", var.name)
    },
    var.tags,
  )
}

module "publicRouteTable" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/route-table.git?ref=main"
  cidr = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.igw.id
  name        = format("%s-pub-rtb", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "Public_Subnet_aza" {
  source = "git@gitlab.com:ot-client/wheebox/terraform-modules/subnet.git?ref=main"
  availability_zones = [element(var.avaialability_zones,0)]
  name = format("%s-pub-aza", var.name)
  route_table_id = module.publicRouteTable.id
  subnets_cidr = [element(tolist(var.public_subnets_cidr),0)]
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "Public_Subnet_azb" {
  source = "git@gitlab.com:ot-client/wheebox/terraform-modules/subnet.git?ref=main"
  availability_zones = [element(var.avaialability_zones,1)]
  name = format("%s-pub-azb", var.name)
  route_table_id = module.publicRouteTable.id
  subnets_cidr = [element(tolist(var.public_subnets_cidr),1)]
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

#nat-gateway and its private table for aza
module "nat-gateway_aza" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/nat-gateway.git?ref=main"
  subnets_for_nat_gw = module.Public_Subnet_aza.ids
  vpc_name = var.name
  tags = merge({
    Name = "nat-gateway-aza"
  },var.tags)
}


module "privateRouteTable_aza" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/route-table.git?ref=main"
  cidr = "0.0.0.0/0"
  gateway_id  = module.nat-gateway_aza.ngw_id
  name        = format("%s-pvt-rtb-aza", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}


module "PrivateSubnets_aza" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/subnet.git?ref=main"
  availability_zones = [element(var.avaialability_zones,0)]
  name = format("%s-pvt-sn-aza", var.name)
  route_table_id = module.privateRouteTable_aza.id
  subnets_cidr = [element(tolist(var.private_subnets_cidr),0)]
  vpc_id      = aws_vpc.main.id
}

#nat-gateway and its private table for azb
module "nat-gateway_azb" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/nat-gateway.git?ref=main"
  subnets_for_nat_gw = module.Public_Subnet_azb.ids
  vpc_name = var.name
  tags = merge({
    Name = "nat-gateway-azb"
  },var.tags)
}

module "privateRouteTable_azb" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/route-table.git?ref=main"
  cidr = "0.0.0.0/0"
  gateway_id  = module.nat-gateway_azb.ngw_id
  name        = format("%s-pvt-rtb-azb", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "PrivateSubnets_azb" {
  source  = "git@gitlab.com:ot-client/wheebox/terraform-modules/subnet.git?ref=main"
  availability_zones = [element(var.avaialability_zones,1)]
  name = format("%s-pvt-sn-azb", var.name)
  route_table_id = module.privateRouteTable_azb.id
  subnets_cidr = [element(tolist(var.private_subnets_cidr),1)]
  vpc_id      = aws_vpc.main.id
}


module "pub_alb_security_group" {
  source  = "OT-CLOUD-KIT/security-groups/aws"
  version = "1.0.0"
  enable_whitelist_ip = true
  name_sg = "Protected ALB Security Group"
  vpc_id   = aws_vpc.main.id
  ingress_rule = {
    rules = {
      rule_list = [
          {
              description = "Rule for port 80"
              from_port = 80
              to_port = 80
              protocol = "tcp"
              cidr = concat(var.whitelist_ip, ["${module.nat-gateway_aza.nat_ip}/32", "${module.nat-gateway_azb.nat_ip}/32"])
              source_SG_ID = []
          },
          { 
              description = "Rule for port 443"
              from_port = 443
              to_port = 443
              protocol = "tcp"
              cidr = concat(var.whitelist_ip, ["${module.nat-gateway_aza.nat_ip}/32", "${module.nat-gateway_azb.nat_ip}/32"])
              source_SG_ID = []
          }
      ]
   }
  }
} 

module "pub_alb" {
  source = "git@gitlab.com:ot-client/wheebox/terraform-modules/alb.git?ref=main"
  alb_name = format("%s-protected-alb", var.name)
  internal = false
  logs_bucket = var.alb_logs_bucket
  security_groups_id = [module.pub_alb_security_group.sg_id]
  subnets_id = concat(module.Public_Subnet_aza.ids,module.Public_Subnet_azb.ids)
  tags =var.tags
  enable_logging = var.enable_alb_logging
  enable_deletion_protection = var.enable_deletion_protection
  enable_https_listener = var.enable_https_listener
  ssl_policy = var.ssl_policy
  certificate_arn = var.certificate_arn
}

resource "aws_route53_zone" "private_hosted_zone" {
  name = var.pvt_zone_name
  vpc {
    vpc_id = aws_vpc.main.id
  }
}

resource "tls_private_key" "pk" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "key" {
  key_name   = format("%s-vpc-key", var.name)      
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./'${aws_key_pair.key.key_name}.pem'"
  }
  
  provisioner "local-exec" {
    command = "chmod 600 ./'${aws_key_pair.key.key_name}.pem'"
  }
}


# As per Protected LB setup we are whitelisting NAT Gateway public IP, but ideall applications running inside VPC should be able to directly interact with ALB via internet
