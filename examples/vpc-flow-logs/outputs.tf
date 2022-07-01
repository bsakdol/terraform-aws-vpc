################################################################################
## CLOUDWATCH                                                                 ##
################################################################################
output "cloudwatch_arn" {
  description = "A map of CloudWatch log group attributes."
  value       = module.vpc_flow_logs_default.cloudwatch_arn
}


################################################################################
## IAM                                                                        ##
################################################################################
output "cloudwatch_iam_policy" {
  description = "A map of CloudWatch IAM policy attributes."
  value       = module.vpc_flow_logs_default.cloudwatch_iam_policy
}

output "cloudwatch_iam_role" {
  description = "A map of CloudWatch IAM role attributes."
  value       = module.vpc_flow_logs_default.cloudwatch_iam_role
}

################################################################################
## VPC FLOW LOGS                                                              ##
################################################################################
output "arn" {
  description = "The ARN of the Flow Log."
  value       = module.vpc_flow_logs_default.arn
}

output "id" {
  description = "The ID of the Flow Log."
  value       = module.vpc_flow_logs_default.id
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = module.vpc_flow_logs_default.tags_all
}

output "vpc_flow_logs_all" {
  description = "A map of VPC Flow Log attributes."
  value       = module.vpc_flow_logs_default.vpc_flow_logs_all
}
