# terraform-aws-vpc

Terraform module for managing AWS VPC resources.

This module makes use of maps, instead of lists, for many resources. This gives us more flexibility in the configuration and more consistency when making changes. For example, if a public subnet is added and needs to be placed before the already provisioned subnets (i.e. you are as particular about organization as I am), Terraform won't think all subnets need to be deleted/created.

## Usage

```hcl
module "vpc" {
  source = "https://github.com/bsakdol/terraform-aws-vpc"

  name = "example-vpc"

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnets = {
    "10.0.10.0/24" = {
      "availability_zone" = "us-east-2a"
    },
    "10.0.11.0/24" = {
      "availability_zone" = "us-east-2b"
    }
  }

  public_subnets = {
    "10.0.20.0/24" = {
      "availability_zone"  = "us-east-2a"
      "create_nat_gateway" = true
    },
    "10.0.21.0/24" = {
      "availability_zone"  = "us-east-2b"
      "create_nat_gateway" = true
    }
  }

  tags = {
    Environment = "development"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}
```

## Subnet Types

This module supports different subnet types to provide different methods of connectivity and access:

- **Internal Subnet:** No internet connectivity to resources created within an internal subnet.
- **Private Subnet:** Internet connectivity is provided through the NAT Gateway.
- **Public Subnet:** Internet connectivity is provided through the Internet Gateway. This is accomplished by mapping public IP addresses to instances, by default, on instance launch. _It is important to remember, instances in a public subnet are directly accessible from the internet. Ensure proper security measures have been taken to mitigate security risks on instances in public subnets._

_NOTE: When provisioning a private subnet, public subnets are also required in order to facilitate provisioning of the NAT Gateway(s). Please see [NAT Gateways](#nat-gateway) for more details._

## NAT Gateway

This module provisions a VPC for a high availability environment. In order to accomplish this, one NAT Gateway in each availability zone, where a private subnet exists, will be provisioned. This design ensures, in the event an availability zone becomes unavailable, resource provisioned in the private subnets of different availability zones will still have internet access.

The NAT Gateway is provisioned with an IP address from a public subnet in the same availability zone as the private subnet(s). For this reason, a minimum of one public subnet must be provisioned in each availability zone where a private subnet is provisioned. It is important to note, if more than one public subnet exists in a single availability zone, only one should be assocated with a NAT Gateway.

## Network Access Control Lists (ACL/NACL)

This module is responsible for managing the NACLs for each of the provisioned subnets. To keep the configuration simple, there are no flags or special attributes to signal Terraform to create the NACLs. Instead, when a [subnet type](#subnet-types) is provisioned, an NACL is also provisioned for the subnets. The NACL for a subnet type is shared for all subnets of the same type, in order to maintain consistency.

By default, when an NACL is provisioned a single rule is implemented to permit all traffic inbound and all traffic outbound. For an example of how to customize the Network ACL rules, please refer to the [complete](examples/complete/) example. For more in-depth information on the available options, please refer to the Terraform documentation for the [network-acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) resource.

## VPC Endpoints

`Interface` and/or `Gateway` VPC Endpoints are managed via a sub-module. This provides the flexibility to manage VPC endpoints independently of the VPC, and resources dependant on the VPC. For more information, please reference the [README.md](modules/vpc-endpoints/README.md) for the sub-module.

## Examples

- [Complete](examples/complete/)
- [Simple](examples/simple/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.internal_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.internal_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.private_nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_ipv4_cidr_block_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be<br>derived from IPAM using `ipv4_netmask_length`. | `string` | `null` | no |
| <a name="input_dhcp_options"></a> [dhcp\_options](#input\_dhcp\_options) | A map of to manage the DHCP options attributes for the VPC. For information<br>about the arguments relevant for this resource type, see [Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options#argument-reference). | `any` | `{}` | no |
| <a name="input_dhcp_options_tags"></a> [dhcp\_options\_tags](#input\_dhcp\_options\_tags) | A map of tags to assign to the DHCP options. Resource specific tags will<br>override all other tags. | `map(string)` | `{}` | no |
| <a name="input_eip_nat_tags"></a> [eip\_nat\_tags](#input\_eip\_nat\_tags) | A map of tags to assign to the EIP resources for the NAT Gateways. Resource<br>specific tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_enable_classiclink"></a> [enable\_classiclink](#input\_enable\_classiclink) | A boolean flag to enable/disable ClassicLink for the VPC. | `bool` | `false` | no |
| <a name="input_enable_classiclink_dns_support"></a> [enable\_classiclink\_dns\_support](#input\_enable\_classiclink\_dns\_support) | A boolean flag to enable/disable ClassicLink DNS Support for the VPC. | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | A boolean flag to enable/disable DNS hostnames in the VPC. | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | A boolean flag to enable/disable DNS support in the VPC. | `bool` | `true` | no |
| <a name="input_igw_tags"></a> [igw\_tags](#input\_igw\_tags) | A map of tags to assign to the internet gateway resource. Resource specific<br>tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC. | `string` | `null` | no |
| <a name="input_internal_route_table_tags"></a> [internal\_route\_table\_tags](#input\_internal\_route\_table\_tags) | A map of tags to assign to the internal route table resource. Resource<br>specific tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_internal_subnets"></a> [internal\_subnets](#input\_internal\_subnets) | A map of attributes to define internal subnets for the VPC. | `any` | `{}` | no |
| <a name="input_internal_subnets_tags"></a> [internal\_subnets\_tags](#input\_internal\_subnets\_tags) | A map of tags to assign to the internal subnets resources. Resource specific<br>tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_manage_vpc"></a> [manage\_vpc](#input\_manage\_vpc) | A boolean flag to control whether or not to manage VPC resources. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used as an identifier of all managed resources. | `string` | `null` | no |
| <a name="input_nat_gateway_tags"></a> [nat\_gateway\_tags](#input\_nat\_gateway\_tags) | A map of tags to assign to the NAT Gateway resources. Resource specific tags<br>will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_network_acl_internal_egress"></a> [network\_acl\_internal\_egress](#input\_network\_acl\_internal\_egress) | A map of egress rules applied to the internal subnets network ACL. | `map(any)` | <pre>{<br>  "100": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "to_port": "0"<br>  }<br>}</pre> | no |
| <a name="input_network_acl_internal_ingress"></a> [network\_acl\_internal\_ingress](#input\_network\_acl\_internal\_ingress) | A map of ingress rules applied to the internal subnets network ACL. | `map(any)` | <pre>{<br>  "100": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "to_port": "0"<br>  }<br>}</pre> | no |
| <a name="input_network_acl_internal_tags"></a> [network\_acl\_internal\_tags](#input\_network\_acl\_internal\_tags) | A map of tags to assign to the Network ACL applied to the internal subnets. | `map(string)` | `{}` | no |
| <a name="input_network_acl_private_egress"></a> [network\_acl\_private\_egress](#input\_network\_acl\_private\_egress) | A map of egress rules applied to the internal subnets network ACL. | `map(any)` | <pre>{<br>  "100": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "to_port": "0"<br>  }<br>}</pre> | no |
| <a name="input_network_acl_private_ingress"></a> [network\_acl\_private\_ingress](#input\_network\_acl\_private\_ingress) | A map of ingress rules applied to the internal subnets network ACL. | `map(any)` | <pre>{<br>  "100": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "to_port": "0"<br>  }<br>}</pre> | no |
| <a name="input_network_acl_private_tags"></a> [network\_acl\_private\_tags](#input\_network\_acl\_private\_tags) | A map of tags to assign to the Network ACL applied to the private subnets. | `map(string)` | `{}` | no |
| <a name="input_network_acl_public_egress"></a> [network\_acl\_public\_egress](#input\_network\_acl\_public\_egress) | A map of egress rules applied to the internal subnets network ACL. | `map(any)` | <pre>{<br>  "100": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "to_port": "0"<br>  }<br>}</pre> | no |
| <a name="input_network_acl_public_ingress"></a> [network\_acl\_public\_ingress](#input\_network\_acl\_public\_ingress) | A map of ingress rules applied to the internal subnets network ACL. | `map(any)` | <pre>{<br>  "100": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "to_port": "0"<br>  }<br>}</pre> | no |
| <a name="input_network_acl_public_tags"></a> [network\_acl\_public\_tags](#input\_network\_acl\_public\_tags) | A map of tags to assign to the Network ACL applied to the public subnets. | `map(string)` | `{}` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | A map of tags to assign to the private route table resource. Resource<br>specific tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A map of attributes to define private subnets for the VPC. | `any` | `{}` | no |
| <a name="input_private_subnets_tags"></a> [private\_subnets\_tags](#input\_private\_subnets\_tags) | A map of tags to assign to the private subnets resources. Resource specific<br>tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | A map of tags to assign to the public route table resource. Resource<br>specific tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A map of attributes to define public subnets for the VPC. | `any` | `{}` | no |
| <a name="input_public_subnets_tags"></a> [public\_subnets\_tags](#input\_public\_subnets\_tags) | A map of tags to assign to the public subnets resources. Resource specific<br>tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. If configured with a provider<br>`default_tags` configuration block present, tags with matching keys will<br>overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_vpc_ipv4_cidr_block_associations"></a> [vpc\_ipv4\_cidr\_block\_associations](#input\_vpc\_ipv4\_cidr\_block\_associations) | A map of additional IPv4 CIDR blocks to associate with the VPC. Requires<br>`cidr_block`, `ipv4_ipam_pool_id`, or `ipv4_netmask_length` to be defined.<br>[Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association#argument-reference) | `any` | `{}` | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | A map of tags to assign to the VPC resource. Resource specific tags will<br>override all other tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of VPC. |
| <a name="output_default_network_acl_id"></a> [default\_network\_acl\_id](#output\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation. |
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation. |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation. |
| <a name="output_dhcp_options"></a> [dhcp\_options](#output\_dhcp\_options) | A map of DHCP options and attributes. |
| <a name="output_enable_classiclink"></a> [enable\_classiclink](#output\_enable\_classiclink) | Whether or not the VPC has Classiclink enabled. |
| <a name="output_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#output\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support. |
| <a name="output_enable_dns_support"></a> [enable\_dns\_support](#output\_enable\_dns\_support) | Whether or not the VPC has DNS support. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPC. |
| <a name="output_instance_tenancy"></a> [instance\_tenancy](#output\_instance\_tenancy) | Tenancy of the instances created within the VPC. |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | A map of internet gateway attributes. |
| <a name="output_ipv4_cidr_block_associations"></a> [ipv4\_cidr\_block\_associations](#output\_ipv4\_cidr\_block\_associations) | A map of IPv4 CIDR block associations and attributes. |
| <a name="output_main_route_table_id"></a> [main\_route\_table\_id](#output\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. |
| <a name="output_nat_elastic_ips"></a> [nat\_elastic\_ips](#output\_nat\_elastic\_ips) | A map of Elastic IPs used for the NAT Gateways. |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | A map of NAT Gateway attributes. |
| <a name="output_network_acl_internal"></a> [network\_acl\_internal](#output\_network\_acl\_internal) | A map of internal subnets network ACL attributes. |
| <a name="output_network_acl_private"></a> [network\_acl\_private](#output\_network\_acl\_private) | A map of private subnets network ACL attributes. |
| <a name="output_network_acl_public"></a> [network\_acl\_public](#output\_network\_acl\_public) | A map of public subnets network ACL attributes. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The ID of the AWS account that owns the VPC. |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | A map of route tables and attributes. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A map of subnet types, subnets, and associated attributes. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the VPC, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_vpc_all"></a> [vpc\_all](#output\_vpc\_all) | A map of VPC attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
