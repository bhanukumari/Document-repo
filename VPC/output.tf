output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "pub_route_table_id" {
  description = "Public route table ID"
  value = module.publicRouteTable.id
}

output "pub_subnet_aza_id" {
  description = "Public Subnet AZA ID" 
  value = module.Public_Subnet_aza.ids[0]
}

output "pub_subnet_azb_id" {
  description = "Public Subnet AZB ID" 
  value = module.Public_Subnet_azb.ids[0]
}


output "pvt_route_table_aza_id" {
  description = "Private Route table ID" 
  value = module.privateRouteTable_aza.id
}

output "pvt_subnet_aza_id" {
  description = "Private Subnet AZA ID" 
  value = module.PrivateSubnets_aza.ids[0]
}

output "pvt_route_table_azb_id" {
  description = "Private Route table ID" 
  value = module.privateRouteTable_azb.id
}

output "pvt_subnet_azb_id" {
  description = "Private Subnet AZB ID" 
  value = module.PrivateSubnets_azb.ids[0]
}

output "pub_alb_dns" {
  value = module.pub_alb.dns_name
}

output "pvt_hosted_zone_id" {
  description = "hosted zone id"
  value       = aws_route53_zone.private_hosted_zone.zone_id
}

output "pub_alb_security_group_id" {
  description = "security group id"
  value = module.pub_alb_security_group.sg_id
}

output "alb_http_listener_arn" {
  value = module.pub_alb.alb_http_listener_arn
}

output "alb_https_listener_arn" {
  value = module.pub_alb.alb_https_listener_arn
}

output "alb_dns" {
  value = module.pub_alb.dns_name
}

output "vpc_default_key" {
  value = aws_key_pair.key.key_name
}
