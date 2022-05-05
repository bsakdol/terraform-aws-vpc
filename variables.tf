variable "cidr_block" {
  type        = string
  default     = null
  description = <<-EOT
    The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be
    derived from IPAM using `ipv4_netmask_length`.
  EOT
}

variable "dhcp_options" {
  type        = any
  default     = {}
  description = <<-EOT
    A map of to manage the DHCP options attributes for the VPC. For information
    about the arguments relevant for this resource type, see [Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options#argument-reference).
  EOT
}

variable "dhcp_options_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the DHCP options. Resource specific tags will
    override all other tags.
  EOT
}

variable "eip_nat_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the EIP resources for the NAT Gateways. Resource
    specific tags will override all other tags.
  EOT
}

variable "enable_classiclink" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable ClassicLink for the VPC."
}

variable "enable_classiclink_dns_support" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC."
}

variable "igw_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the internet gateway resource. Resource specific
    tags will override all other tags.
  EOT
}

variable "instance_tenancy" {
  type        = string
  default     = null
  description = "A tenancy option for instances launched into the VPC."
}

variable "internal_subnets" {
  type        = any
  default     = {}
  description = "A map of attributes to define internal subnets for the VPC."
}

variable "internal_route_table_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the internal route table resource. Resource
    specific tags will override all other tags.
  EOT
}

variable "internal_subnets_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the internal subnets resources. Resource specific
    tags will override all other tags.
  EOT
}

variable "manage_vpc" {
  type        = bool
  default     = true
  description = "A boolean flag to control whether or not to manage VPC resources."
}

variable "name" {
  type        = string
  default     = null
  description = "Name to be used as an identifier of all managed resources."
}

variable "nat_gateway_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the NAT Gateway resources. Resourcespecific tags
    will override all other tags.
  EOT
}

variable "network_acl_internal_egress" {
  type = map(any)
  default = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }
  description = "A map of egress rules applied to the internal subnets network ACL."
}

variable "network_acl_internal_ingress" {
  type = map(any)
  default = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }
  description = "A map of ingress rules applied to the internal subnets network ACL."
}

variable "network_acl_internal_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the Network ACL applied to the internal subnets.
  EOT
}

variable "network_acl_private_egress" {
  type = map(any)
  default = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }
  description = "A map of egress rules applied to the internal subnets network ACL."
}

variable "network_acl_private_ingress" {
  type = map(any)
  default = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }
  description = "A map of ingress rules applied to the internal subnets network ACL."
}

variable "network_acl_private_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the Network ACL applied to the private subnets.
  EOT
}

variable "network_acl_public_egress" {
  type = map(any)
  default = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }
  description = "A map of egress rules applied to the internal subnets network ACL."
}

variable "network_acl_public_ingress" {
  type = map(any)
  default = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }
  description = "A map of ingress rules applied to the internal subnets network ACL."
}

variable "network_acl_public_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the Network ACL applied to the public subnets.
  EOT
}

variable "private_subnets" {
  type        = any
  default     = {}
  description = "A map of attributes to define private subnets for the VPC."
}

variable "private_route_table_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the private route table resource. Resource
    specific tags will override all other tags.
  EOT
}

variable "private_subnets_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the private subnets resources. Resource specific
    tags will override all other tags.
  EOT
}

variable "public_subnets" {
  type        = any
  default     = {}
  description = "A map of attributes to define public subnets for the VPC."
}

variable "public_route_table_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the public route table resource. Resource
    specific tags will override all other tags.
  EOT
}

variable "public_subnets_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the public subnets resources. Resource specific
    tags will override all other tags.
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

variable "vpc_ipv4_cidr_block_associations" {
  type        = any
  default     = {}
  description = <<-EOT
    A map of additional IPv4 CIDR blocks to associate with the VPC. Requires
    `cidr_block`, `ipv4_ipam_pool_id`, or `ipv4_netmask_length` to be defined.
    [Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association#argument-reference)
  EOT
}

variable "vpc_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the VPC resource. Resource specific tags will
    override all other tags.
  EOT
}
