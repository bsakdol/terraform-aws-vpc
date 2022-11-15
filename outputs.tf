################################################################################
## DHCP OPTIONS SET                                                           ##
################################################################################
output "dhcp_options" {
  description = "A map of DHCP options and attributes."
  value       = try(aws_vpc_dhcp_options.this, null)
}

################################################################################
## INTERNET GATEWAY                                                           ##
################################################################################
output "internet_gateway" {
  description = "A map of internet gateway attributes."
  value       = try(aws_internet_gateway.this, null)
}

################################################################################
## NAT GATEWAYS                                                               ##
################################################################################
output "nat_elastic_ips" {
  description = "A map of Elastic IPs used for the NAT Gateways."
  value       = try(aws_eip.nat, null)
}

output "nat_gateways" {
  description = "A map of NAT Gateway attributes."
  value       = try(aws_nat_gateway.this, null)
}

################################################################################
## NETWORK ACLs                                                               ##
################################################################################
output "network_acl_internal" {
  description = "A map of internal subnets network ACL attributes."
  value       = try(aws_network_acl.internal[0], null)
}

output "network_acl_private" {
  description = "A map of private subnets network ACL attributes."
  value       = try(aws_network_acl.private[0], null)
}

output "network_acl_public" {
  description = "A map of public subnets network ACL attributes."
  value       = try(aws_network_acl.public[0], null)
}

################################################################################
## ROUTE TABLES                                                               ##
################################################################################
output "route_tables" {
  description = "A map of route tables and attributes."
  value = {
    "internal" = try(aws_route_table.internal, null)
    "private"  = try(aws_route_table.private, null)
    "public"   = try(aws_route_table.public, null)
  }
}

################################################################################
## SECONDARY CIDR BLOCK ASSOCIATIONS                                          ##
################################################################################
output "ipv4_cidr_block_associations" {
  description = "A map of IPv4 CIDR block associations and attributes."
  value       = try(aws_vpc_ipv4_cidr_block_association.this, null)
}

################################################################################
## SUBNETS                                                                    ##
################################################################################
output "subnets" {
  description = "A map of subnet types, subnets, and associated attributes."
  value = {
    "internal" = try(aws_subnet.internal, null)
    "private"  = try(aws_subnet.private, null)
    "public"   = try(aws_subnet.public, null)
  }
}

################################################################################
## VPC                                                                        ##
################################################################################
output "arn" {
  description = "Amazon Resource Name (ARN) of VPC."
  value       = try(aws_vpc.this[0].arn)
}

output "default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation."
  value       = try(aws_vpc.this[0].default_network_acl_id)
}

output "default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation."
  value       = try(aws_vpc.this[0].default_route_table_id)
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation."
  value       = try(aws_vpc.this[0].default_security_group_id)
}

output "enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support."
  value       = try(aws_vpc.this[0].enable_dns_hostnames)
}

output "enable_dns_support" {
  description = "Whether or not the VPC has DNS support."
  value       = try(aws_vpc.this[0].enable_dns_support)
}

output "id" {
  description = "The ID of the VPC."
  value       = try(aws_vpc.this[0].id)
}

output "instance_tenancy" {
  description = "Tenancy of the instances created within the VPC."
  value       = try(aws_vpc.this[0].id)
}

output "main_route_table_id" {
  description = "The ID of the main route table associated with this VPC."
  value       = try(aws_vpc.this[0].main_route_table_id)
}

output "owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = try(aws_vpc.this[0].owner_id)
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the VPC, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = try(aws_vpc.this[0].tags_all)
}

output "vpc_all" {
  description = "A map of VPC attributes."
  value       = try(aws_vpc.this[0], null)
}
