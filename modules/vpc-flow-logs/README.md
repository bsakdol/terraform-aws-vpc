# AWS VPC Flow Logs Terraform Sub-Module

Terraform module for managing AWS VPC flow logs.

## Usage

**IMPORTANT NOTE:** The `main` branch is used as the module source for the usage examples, in place of the version. It is important to pin the release tag (e.g. `?ref=tags/x.y.z`) for the module to the source, when using any portion of this module to provision resources. The `main` branch may contain undocumented breaking changes.

**Create VPC Flow Logs and push them to a new AWS CloudWatch Log group.**

```hcl
module "vpc_flow_logs_default" {
  source = "https://github.com/bsakdol/terraform-aws-vpc//modules/vpc-flow-logs?ref=main"

  create_cloudwatch_iam_role  = true
  create_cloudwatch_log_group = true

  vpc_id = "vpc-987321654afbecd"

  tags = {
    "Environment" = "development"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}

```

**Create VPC Flow Logs and push them to an existing AWS CloudWatch Log group.**

```hcl
module "vpc_flow_logs_default" {
  source = "https://github.com/bsakdol/terraform-aws-vpc//modules/vpc-flow-logs?ref=main"

  cloudwatch_iam_role_arn = "arn:aws:iam::123456789:role/vpc-flow-log-role-134679"
  log_destination_arn     = "arn:aws:logs:us-east-2:123456789:log-group:/aws/vpc-flow-log/vpc-987321654afbecd"
  log_destination_type    = "cloud-watch-logs"

  vpc_id = "vpc-987321654afbecd"

  tags = {
    "Environment" = "development"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}

```

**Create VPC Flow Logs and push them to an existing S3 bucket.**

```hcl
module "vpc_flow_logs_default" {
  source = "https://github.com/bsakdol/terraform-aws-vpc//modules/vpc-flow-logs?ref=main"

  log_destination_arn     = "arn:aws:s3:::vpc-flow-logs-to-s3-1"
  log_destination_type    = "s3"

  vpc_id = "vpc-987321654afbecd"

  tags = {
    "Environment" = "development"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}

```

## Examples

- [VPC Flow Logs with CloudWatch](../../examples/vpc-flow-logs/)
- [VPC Flow Logs with S3](../../examples/vpc-flow-logs-s3/)

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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_iam_role_arn"></a> [cloudwatch\_iam\_role\_arn](#input\_cloudwatch\_iam\_role\_arn) | The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group. | `string` | `null` | no |
| <a name="input_create_cloudwatch_iam_role"></a> [create\_cloudwatch\_iam\_role](#input\_create\_cloudwatch\_iam\_role) | Indicates whether or not to create an IAM role for use with the flow log. If<br>not set to `true`, `cloudwatch_iam_role_arn` must be defined. `flow_log_destination_type`<br>must be `s3` with this argument set `true`. | `bool` | `false` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Indicates whether or not to create a log group for the flow flog. If not set<br>to `true`, `log_destination_arn` must be defined. `flow_log_destination_type`<br>must be `s3` with this argument set `true`. | `bool` | `false` | no |
| <a name="input_file_format"></a> [file\_format](#input\_file\_format) | The format for the flow log. Valid values: `plain-text`, `parquet`. | `string` | `null` | no |
| <a name="input_hive_compatible_partitions"></a> [hive\_compatible\_partitions](#input\_hive\_compatible\_partitions) | Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3. | `bool` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_log_destination_arn"></a> [log\_destination\_arn](#input\_log\_destination\_arn) | The ARN of the logging destination. | `string` | `null` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | The type of the logging destination. Valid values: `cloud-watch-logs`, `s3`. | `string` | `"cloud-watch-logs"` | no |
| <a name="input_log_format"></a> [log\_format](#input\_log\_format) | The fields to include in the flow log record, in the order in which they should appear. | `string` | `null` | no |
| <a name="input_log_group_kms_key_id"></a> [log\_group\_kms\_key\_id](#input\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. Please note, after<br>the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs<br>stops encrypting newly ingested data for the log group. All previously<br>ingested data remains encrypted, and AWS CloudWatch Logs requires<br>permissions for the CMK whenever the encrypted data is requested. | `string` | `null` | no |
| <a name="input_log_group_name_prefix"></a> [log\_group\_name\_prefix](#input\_log\_group\_name\_prefix) | The name prefix of the CloudWatch log group for the VPC flow logs. The VPC<br>ID will be appended after the name prefix to form the log group name. | `string` | `"/aws/vpc-flow-log/"` | no |
| <a name="input_log_group_retention_in_days"></a> [log\_group\_retention\_in\_days](#input\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified<br>log group. Possible values are: `1`, `3`, `5`, `7`, `14`, `30`, `60`, `90`,<br>`120`, `150`, `180`, `365`, `400`, `545`, `731`, `1827`, `3653`, and `0`. If<br>you select 0, the events in the log group are always retained and never expire. | `number` | `null` | no |
| <a name="input_max_aggregation_interval"></a> [max\_aggregation\_interval](#input\_max\_aggregation\_interval) | The maximum interval of time during which a flow of packets is captured and<br>aggregated into a flow log record. Valid Values: `60` seconds (1 minute) or<br>`600` seconds (10 minutes). | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used as an identifier of all managed resources. | `string` | `null` | no |
| <a name="input_per_hour_partition"></a> [per\_hour\_partition](#input\_per\_hour\_partition) | Indicates whether to partition the flow log per hour. This reduces the cost<br>and response time for queries. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. If configured with a provider<br>`default_tags` configuration block present, tags with matching keys will<br>overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | The type of traffic to capture. Valid values: `ACCEPT`, `REJECT`, `ALL`. | `string` | `"ALL"` | no |
| <a name="input_vpc_flow_log_tags"></a> [vpc\_flow\_log\_tags](#input\_vpc\_flow\_log\_tags) | A map of tags to assign to the VPC flow log resources. Resource specific<br>tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to attach to. | `string` | `null` | no |

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
