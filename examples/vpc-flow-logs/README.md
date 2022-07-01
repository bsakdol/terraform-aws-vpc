# VPC Flow Logs to CloudWatch Example

This module builds a VPC with VPC Flow Logs, to a CloudWatch log group, in the `US-East-2` region of AWS.

When applying this configuration, the environment will be provisioned with private, and public subnets--one of each subnet type in `us-east-2a`. Additionally, one NAT Gateway will be provisioned for use by the private subnet, and one Internet gateway will be provisioned for use by the public subnet.

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

_NOTE: Resources in this example may cost money, so it is important to understand AWS pricing prior to provisioning._

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../ | n/a |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../../modules/vpc-endpoints | n/a |
| <a name="module_vpc_flow_logs_default"></a> [vpc\_flow\_logs\_default](#module\_vpc\_flow\_logs\_default) | ../../modules/vpc-flow-logs | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Flow Log. |
| <a name="output_cloudwatch_arn"></a> [cloudwatch\_arn](#output\_cloudwatch\_arn) | A map of CloudWatch log group attributes. |
| <a name="output_cloudwatch_iam_policy"></a> [cloudwatch\_iam\_policy](#output\_cloudwatch\_iam\_policy) | A map of CloudWatch IAM policy attributes. |
| <a name="output_cloudwatch_iam_role"></a> [cloudwatch\_iam\_role](#output\_cloudwatch\_iam\_role) | A map of CloudWatch IAM role attributes. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Flow Log. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_vpc_flow_logs_all"></a> [vpc\_flow\_logs\_all](#output\_vpc\_flow\_logs\_all) | A map of VPC Flow Log attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
