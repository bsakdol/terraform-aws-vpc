# Simple VPC Example

This module builds an example VPC in the `US-East-2` region of AWS. The example configuration in this directory provides a sample configuration which may be suitable for development and testing environments.

When applying this configuration, the environment will be provisioned with private, and public subnets--one of each subnet type in `us-east-2a` and `us-east-2b`. Additionally, one NAT Gateway will be provisioned in each availability zone for use by the private subnets, and one Internet gateway will be provisioned for use by the public subnets.

## Usage

To provision the environment in this example, the following commands will need to be executed:

```hcl
terraform init
terraform apply
```

When resources are no longer being used, run the following command to destroy them:

```hcl
terraform destroy
```

*NOTE: Resources in this example may cost money, so it is important to understand AWS pricing prior to provisioning.*

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.60.0, < 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | A map of internet gateway attributes. |
| <a name="output_nat_elastic_ips"></a> [nat\_elastic\_ips](#output\_nat\_elastic\_ips) | A map of Elastic IPs used for the NAT Gateways. |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | A map of NAT Gateway attributes. |
| <a name="output_route_tables"></a> [route\_tables](#output\_route\_tables) | A map of route tables and attributes. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A map of subnet types, subnets, and associated attributes. |
| <a name="output_vpc_all"></a> [vpc\_all](#output\_vpc\_all) | A map of VPC attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
