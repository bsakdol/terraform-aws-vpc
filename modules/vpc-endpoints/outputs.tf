################################################################################
## VPC ENDPOINTS                                                              ##
################################################################################
output "arns" {
  description = "The Amazon Resource Name (ARN) of the VPC endpoint."
  value       = try(aws_vpc_endpoint.this[*].arn, null)
}

output "cidr_blocks" {
  description = <<-EOT
    The list of CIDR blocks for the exposed AWS service. Applicable for
    endpoints of type Gateway.
  EOT
  value       = try(aws_vpc_endpoint.this[*].cidr_blocks, null)
}

output "dns_entries" {
  description = "The DNS entries for the VPC Endpoints. Applicable for endpoints of type Interface."
  value       = try(aws_vpc_endpoint.this[*].dns_entry, null)
}

output "ids" {
  description = "The ID of the VPC endpoints."
  value       = try(aws_vpc_endpoint.this[*].id, null)
}

output "network_interface_ids" {
  description = <<-EOT
    One or more network interfaces for the VPC Endpoints. Applicable for
    endpoints of type Interface.
  EOT
  value       = try(aws_vpc_endpoint.this[*].network_interface_ids, null)
}

output "owner_ids" {
  description = "The ID of the AWS account that owns the VPC endpoints."
  value       = try(aws_vpc_endpoint.this[*].owner_id, null)
}

output "prefix_list_ids" {
  description = <<-EOT
    The prefix list ID of the exposed AWS service. Applicable for endpoints of
    type Gateway.
  EOT
  value       = try(aws_vpc_endpoint.this[*].prefix_list_id, null)
}

output "requestor_managed" {
  description = "Whether or not the VPC Endpoint is being managed by its service."
  value       = try(aws_vpc_endpoint.this[*].requestor_managed, null)
}

output "states" {
  description = "The state of the VPC endpoint."
  value       = try(aws_vpc_endpoint.this[*].state, null)
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the VPC Endpoints, including those inherited from
    the provider `default_tags` configuration block.
  EOT
  value       = try(aws_vpc_endpoint.this[*].tags_all, null)
}

output "vpc_endpoints_all" {
  description = "A map of VPC endpoints attributes."
  value       = try(aws_vpc_endpoint.this, null)
}
