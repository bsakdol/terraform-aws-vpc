variable "cloudwatch_iam_role_arn" {
  type        = string
  default     = null
  description = <<-EOT
    The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group.
  EOT
}

variable "create_cloudwatch_iam_role" {
  type        = bool
  default     = false
  description = <<-EOT
    Indicates whether or not to create an IAM role for use with the flow log. If
    not set to `true`, `cloudwatch_iam_role_arn` must be defined. `flow_log_destination_type`
    must be `s3` with this argument set `true`.
  EOT
}

variable "create_cloudwatch_log_group" {
  type        = bool
  default     = false
  description = <<-EOT
    Indicates whether or not to create a log group for the flow flog. If not set
    to `true`, `log_destination_arn` must be defined. `flow_log_destination_type`
    must be `s3` with this argument set `true`.
  EOT
}

variable "file_format" {
  type        = string
  default     = null
  description = <<-EOT
    The format for the flow log. Valid values: `plain-text`, `parquet`.
  EOT
}

variable "hive_compatible_partitions" {
  type        = bool
  default     = null
  description = <<-EOT
    Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3.
  EOT
}

variable "iam_role_permissions_boundary" {
  type        = string
  default     = null
  description = <<-EOT
    ARN of the policy that is used to set the permissions boundary for the role.
  EOT
}

variable "log_destination_arn" {
  type        = string
  default     = null
  description = "The ARN of the logging destination."
}

variable "log_destination_type" {
  type        = string
  default     = "cloud-watch-logs"
  description = <<-EOT
    The type of the logging destination. Valid values: `cloud-watch-logs`, `s3`.
  EOT
}

variable "log_format" {
  type        = string
  default     = null
  description = <<-EOT
    The fields to include in the flow log record, in the order in which they should appear.
  EOT
}

variable "log_group_kms_key_id" {
  type        = string
  default     = null
  description = <<-EOT
    The ARN of the KMS Key to use when encrypting log data. Please note, after
    the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs
    stops encrypting newly ingested data for the log group. All previously
    ingested data remains encrypted, and AWS CloudWatch Logs requires
    permissions for the CMK whenever the encrypted data is requested.
  EOT
}

variable "log_group_name_prefix" {
  type        = string
  default     = "/aws/vpc-flow-log/"
  description = <<-EOT
    The name prefix of the CloudWatch log group for the VPC flow logs. The VPC
    ID will be appended after the name prefix to form the log group name.
  EOT
}

variable "log_group_retention_in_days" {
  type        = number
  default     = null
  description = <<-EOT
    Specifies the number of days you want to retain log events in the specified
    log group. Possible values are: `1`, `3`, `5`, `7`, `14`, `30`, `60`, `90`,
    `120`, `150`, `180`, `365`, `400`, `545`, `731`, `1827`, `3653`, and `0`. If
    you select 0, the events in the log group are always retained and never expire.
  EOT
}

variable "max_aggregation_interval" {
  type        = number
  default     = null
  description = <<-EOT
    The maximum interval of time during which a flow of packets is captured and
    aggregated into a flow log record. Valid Values: `60` seconds (1 minute) or
    `600` seconds (10 minutes).
  EOT
}

variable "name" {
  type        = string
  default     = null
  description = "Name to be used as an identifier of all managed resources."
}

variable "per_hour_partition" {
  type        = bool
  default     = null
  description = <<-EOT
    Indicates whether to partition the flow log per hour. This reduces the cost
    and response time for queries.
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

variable "traffic_type" {
  type        = string
  default     = "ALL"
  description = <<-EOT
    The type of traffic to capture. Valid values: `ACCEPT`, `REJECT`, `ALL`.
  EOT
}

variable "vpc_flow_log_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the VPC flow log resources. Resource specific
    tags will override all other tags.
  EOT
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "VPC ID to attach to."
}
