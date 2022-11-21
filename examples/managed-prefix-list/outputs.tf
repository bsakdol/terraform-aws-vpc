################################################################################
## MANAGED PREFIX LIST                                                        ##
################################################################################
output "managed_prefix_list_all" {
  description = "All the attributes for the provisioned managed prefix lists."
  value       = module.vpc_endpoints.managed_prefix_list_all
}
