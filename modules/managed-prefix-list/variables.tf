variable "managed_prefix_list_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the managed prefix list resource. Resource
    specific tags will override less specific tags.
  EOT
}

variable "managed_prefix_lists" {
  type = list(object({
    address_family = optional(string)
    cidr_blocks    = list(string)
    description    = optional(string)
    max_entries    = number
    name           = string
    tags           = optional(map(string))
  }))
  default = [{
    address_family = "IPv4"
    cidr_blocks    = []
    description    = null
    max_entries    = null
    name           = null
    tags           = {}
  }]
  description = <<-EOT
    The managed prefix lists to be configured for the region. This map contains
    all the attributes necessary for provisioning. For additional details about
    the individual attributes, see the Terraform documentation for the
    `aws_ec2_managed_prefix_list` and `aws_ec2_managed_prefix_list_entry` resources.
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
