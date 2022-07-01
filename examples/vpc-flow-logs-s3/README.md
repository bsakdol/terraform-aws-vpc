# VPC Flow Logs to S3 Example

This module builds a VPC with VPC Flow Logs, pushed to an S3 bucket, in the `US-East-2` region of AWS. The S3 bucket and related dependencies will be provisioned in `s3.tf`, as those resources are not part of the module, but are required for the example.

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
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../ | n/a |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../../modules/vpc-endpoints | n/a |
| <a name="module_vpc_flow_logs_default"></a> [vpc\_flow\_logs\_default](#module\_vpc\_flow\_logs\_default) | ../../modules/vpc-flow-logs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [random_integer.s3](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [aws_iam_policy_document.vpc_flow_log_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Flow Log. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Flow Log. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_vpc_flow_logs_all"></a> [vpc\_flow\_logs\_all](#output\_vpc\_flow\_logs\_all) | A map of VPC Flow Log attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
