################################################################################
## DHCP OPTIONS SET                                                           ##
################################################################################
output "dhcp_options" {
  description = "A map of DHCP options and attributes."
  value       = module.vpc.dhcp_options
}

################################################################################
## INTERNET GATEWAY                                                           ##
################################################################################
output "internet_gateway" {
  description = "A map of internet gateway attributes."
  value       = module.vpc.internet_gateway
}

################################################################################
## NAT GATEWAYS                                                               ##
################################################################################
output "nat_elastic_ips" {
  description = "A map of Elastic IPs used for the NAT Gateways."
  value       = module.vpc.nat_elastic_ips
}

output "nat_gateways" {
  description = "A map of NAT Gateway attributes."
  value       = module.vpc.nat_gateways
}

################################################################################
## NETWORK ACLs                                                               ##
################################################################################
output "network_acl_internal" {
  description = "A map of internal subnets network ACL attributes."
  value       = module.vpc.network_acl_internal
}

output "network_acl_private" {
  description = "A map of private subnets network ACL attributes."
  value       = module.vpc.network_acl_private
}

output "network_acl_public" {
  description = "A map of public subnets network ACL attributes."
  value       = module.vpc.network_acl_public
}

################################################################################
## ROUTE TABLES                                                               ##
################################################################################
output "route_tables" {
  description = "A map of route tables and attributes."
  value       = module.vpc.route_tables
}

################################################################################
## SECONDARY CIDR BLOCK ASSOCIATIONS                                          ##
################################################################################
output "ipv4_cidr_block_associations" {
  description = "A map of IPv4 CIDR block associations and attributes."
  value       = module.vpc.ipv4_cidr_block_associations
}

################################################################################
## SUBNETS                                                                    ##
################################################################################
output "subnets" {
  description = "A map of subnet types, subnets, and associated attributes."
  value       = module.vpc.subnets
}

################################################################################
## VPC                                                                        ##
################################################################################
output "vpc_all" {
  description = "A map of VPC attributes."
  value       = module.vpc.vpc_all
}

output "vpc_arn" {
  description = "Amazon Resource Name (ARN) of VPC."
  value       = module.vpc.arn
}

output "vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation."
  value       = module.vpc.default_network_acl_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation."
  value       = module.vpc.default_route_table_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation."
  value       = module.vpc.default_security_group_id
}

output "vpc_enable_classiclink" {
  description = "Whether or not the VPC has Classiclink enabled."
  value       = module.vpc.enable_classiclink
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support."
  value       = module.vpc.enable_dns_hostnames
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support."
  value       = module.vpc.enable_dns_support
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.id
}

output "vpc_instance_tenancy" {
  description = "Tenancy of the instances created within the VPC."
  value       = module.vpc.instance_tenancy
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC."
  value       = module.vpc.main_route_table_id
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = module.vpc.owner_id
}

output "vpc_tags_all" {
  description = <<-EOT
    A map of tags assigned to the VPC, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = module.vpc.tags_all
}

################################################################################
## VPC ENDPOINTS                                                              ##
################################################################################
output "vpc_endpoints_all" {
  description = "A map of VPC endpoints attributes."
  value       = module.vpc_endpoints.vpc_endpoints_all
}
