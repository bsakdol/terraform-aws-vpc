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
## ROUTE TABLES                                                               ##
################################################################################
output "route_tables" {
  description = "A map of route tables and attributes."
  value       = module.vpc.route_tables
}

################################################################################
## SUBNETS                                                                    ##
################################################################################
output "subnets" {
  description = "A map of subnet types, subnets, and associated attributes."
  value       = module.vpc.subnets.private
}

################################################################################
## VPC                                                                        ##
################################################################################
output "vpc_all" {
  description = "A map of VPC attributes."
  value       = module.vpc.vpc_all
}
