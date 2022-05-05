variable "endpoint_defaults" {
  type        = any
  default     = {}
  description = "A map of default values to use with the VPC endpoint services."
}

variable "endpoints" {
  type        = any
  default     = {}
  description = <<-EOT
    A map of endpoint services and attributes to provision and associate with
    a VPC. For information on all the available attributes to use within the map,
    please see the [aws_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) Terraform resource documentation.
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the resource. If configured with a provider
    `default_tags` configuration block present, tags with matching keys will
    overwrite those defined at the provider-level.
  EOT
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The ID of the VPC to associate endpoints with."
}
