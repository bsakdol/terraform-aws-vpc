################################################################################
## CLOUDWATCH                                                                 ##
################################################################################
output "cloudwatch_arn" {
  description = "A map of CloudWatch log group attributes."
  value       = try(aws_cloudwatch_log_group.this[0], null)
}


################################################################################
## IAM                                                                        ##
################################################################################
output "cloudwatch_iam_policy" {
  description = "A map of CloudWatch IAM policy attributes."
  value       = try(aws_iam_policy.this[0], null)
}

output "cloudwatch_iam_role" {
  description = "A map of CloudWatch IAM role attributes."
  value       = try(aws_iam_role.this[0], null)
}

################################################################################
## VPC FLOW LOGS                                                              ##
################################################################################
output "arn" {
  description = "The ARN of the Flow Log."
  value       = try(aws_flow_log.this.arn, null)
}

output "id" {
  description = "The ID of the Flow Log."
  value       = try(aws_flow_log.this.id, null)
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = try(aws_flow_log.this.tags_all, null)
}

output "vpc_flow_logs_all" {
  description = "A map of VPC Flow Log attributes."
  value       = try(aws_flow_log.this, null)
}
