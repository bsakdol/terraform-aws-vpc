# AWS VPC Endpoints Terraform Sub-Module

Terraform module for managing AWS VPC Endpoints.

## Usage

```hcl
module "vpc" {
  source = "https://github.com/bsakdol/terraform-aws-vpc//modules/vpc-endpoints"

  vpc_id = "vpc-123456abcdef"

  endpoints = {
      codedeploy = {
          vpc_endpoint_type   = "Interface"
          private_dns_enabled = true
      },
      lambda = {
          vpc_endpoint_type   = "Interface"
          private_dns_enabled = true
          subnet_ids          = ["subnet-abcdef123", "subnet-154ade975"]
      },
      s3 = {
          vpc_endpoint_type = "Gateway"
          tags              = { "Name" = "s3-private-vpc-endpoint" }
      }
  }

  endpoint_defaults = {
    route_table_ids    = ["rt-123456789", "rt-987654321"]
    security_group_ids = ["sg-abc123def456"]
    subnet_ids         = ["subnet-111222333", "subnet-444555666", "subnet-777888999"]
  }

  tags = {
    Environment = "development"
    Owner       = "bsakdol"
  }
}
```

## Examples

- [Complete](../../examples/complete/)

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
| [aws_vpc_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoint_defaults"></a> [endpoint\_defaults](#input\_endpoint\_defaults) | A map of default values to use with the VPC endpoint services. | `any` | `{}` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | A map of endpoint services and attributes to provision and associate with<br>a VPC. For information on all the available attributes to use within the map,<br>please see the [aws\_vpc\_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) Terraform resource documentation. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. If configured with a provider<br>`default_tags` configuration block present, tags with matching keys will<br>overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to associate endpoints with. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arns"></a> [arns](#output\_arns) | The Amazon Resource Name (ARN) of the VPC endpoint. |
| <a name="output_cidr_blocks"></a> [cidr\_blocks](#output\_cidr\_blocks) | The list of CIDR blocks for the exposed AWS service. Applicable for<br>endpoints of type Gateway. |
| <a name="output_dns_entries"></a> [dns\_entries](#output\_dns\_entries) | The DNS entries for the VPC Endpoints. Applicable for endpoints of type Interface. |
| <a name="output_ids"></a> [ids](#output\_ids) | The ID of the VPC endpoints. |
| <a name="output_network_interface_ids"></a> [network\_interface\_ids](#output\_network\_interface\_ids) | One or more network interfaces for the VPC Endpoints. Applicable for<br>endpoints of type Interface. |
| <a name="output_owner_ids"></a> [owner\_ids](#output\_owner\_ids) | The ID of the AWS account that owns the VPC endpoints. |
| <a name="output_prefix_list_ids"></a> [prefix\_list\_ids](#output\_prefix\_list\_ids) | The prefix list ID of the exposed AWS service. Applicable for endpoints of<br>type Gateway. |
| <a name="output_requester_managed"></a> [requester\_managed](#output\_requester\_managed) | Whether or not the VPC Endpoint is being managed by its service. |
| <a name="output_states"></a> [states](#output\_states) | The state of the VPC endpoint. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the VPC Endpoints, including those inherited from<br>the provider `default_tags` configuration block. |
| <a name="output_vpc_endpoints_all"></a> [vpc\_endpoints\_all](#output\_vpc\_endpoints\_all) | A map of VPC endpoints attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
