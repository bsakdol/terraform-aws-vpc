# Complete VPC Example

This module builds an example VPC in the `US-East-2` region of AWS. The example configuration in this directory provides a sample of each common configuration option available. For more niche configuration options, it may be necessary to reference the main [README](../../README.md).

When applying this configuration, the environment will be provisioned with internal, private, and public subnets--one of each subnet type in `us-east-2a`, `us-east-2b`, and `us-east-2c`. Additionally, one NAT Gateway will be provisioned in each availability zone for use by the private subnets, and one Internet gateway will be provisioned for use by the public subnets.

## Usage

To provision the environment in this example, the following commands will need to be executed:

```hcl
terraform init
terraform apply
```

When resources are no longer being used, run the following command to destroy them:

```hcl
# terraform destroy
```

_NOTE: Resources in this example may cost money, so it is important to understand AWS pricing prior to provisioning._

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../ | n/a |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../../modules/vpc-endpoints | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.dynamodb_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dhcp_options"></a> [dhcp\_options](#output\_dhcp\_options) | A map of DHCP options and attributes. |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | A map of internet gateway attributes. |
| <a name="output_ipv4_cidr_block_associations"></a> [ipv4\_cidr\_block\_associations](#output\_ipv4\_cidr\_block\_associations) | A map of IPv4 CIDR block associations and attributes. |
| <a name="output_nat_elastic_ips"></a> [nat\_elastic\_ips](#output\_nat\_elastic\_ips) | A map of Elastic IPs used for the NAT Gateways. |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | A map of NAT Gateway attributes. |
| <a name="output_network_acl_internal"></a> [network\_acl\_internal](#output\_network\_acl\_internal) | A map of internal subnets network ACL attributes. |
| <a name="output_network_acl_private"></a> [network\_acl\_private](#output\_network\_acl\_private) | A map of private subnets network ACL attributes. |
| <a name="output_network_acl_public"></a> [network\_acl\_public](#output\_network\_acl\_public) | A map of public subnets network ACL attributes. |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | A map of route tables and attributes. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A map of subnet types, subnets, and associated attributes. |
| <a name="output_vpc_all"></a> [vpc\_all](#output\_vpc\_all) | A map of VPC attributes. |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | Amazon Resource Name (ARN) of VPC. |
| <a name="output_vpc_default_network_acl_id"></a> [vpc\_default\_network\_acl\_id](#output\_vpc\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation. |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation. |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation. |
| <a name="output_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#output\_vpc\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support. |
| <a name="output_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#output\_vpc\_enable\_dns\_support) | Whether or not the VPC has DNS support. |
| <a name="output_vpc_endpoints_all"></a> [vpc\_endpoints\_all](#output\_vpc\_endpoints\_all) | A map of VPC endpoints attributes. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
| <a name="output_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#output\_vpc\_instance\_tenancy) | Tenancy of the instances created within the VPC. |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | The ID of the AWS account that owns the VPC. |
| <a name="output_vpc_tags_all"></a> [vpc\_tags\_all](#output\_vpc\_tags\_all) | A map of tags assigned to the VPC, including those inherited from the<br>provider `default_tags` configuration block. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
