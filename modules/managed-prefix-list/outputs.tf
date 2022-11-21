################################################################################
## MANAGED PREFIX LIST                                                        ##
################################################################################
output "managed_prefix_list_all" {
  description = "All the attributes for the provisioned managed prefix lists."
  value       = try(aws_ec2_managed_prefix_list.this[*], null)
}
