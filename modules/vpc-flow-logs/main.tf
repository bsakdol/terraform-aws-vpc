data "aws_iam_policy_document" "cloudwatch" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  statement {
    sid    = "AWSVPCFlowLogsPushToCloudWatch"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_assume_role" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  statement {
    sid    = "AWSVPCFlowLogsAssumeRole"
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

locals {
  create_cloudwatch_iam_role  = var.log_destination_type != "s3" && var.create_cloudwatch_iam_role
  create_cloudwatch_log_group = var.log_destination_type != "s3" && var.create_cloudwatch_log_group

  iam_role_arn        = var.log_destination_type != "s3" && local.create_cloudwatch_iam_role ? aws_iam_role.this[0].arn : var.cloudwatch_iam_role_arn
  log_destination_arn = local.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[0].arn : var.log_destination_arn
}

################################################################################
## FLOW LOGS                                                                  ##
################################################################################
resource "aws_flow_log" "this" {
  traffic_type = var.traffic_type

  iam_role_arn             = local.iam_role_arn
  log_destination          = local.log_destination_arn
  log_destination_type     = var.log_destination_type
  log_format               = var.log_format
  max_aggregation_interval = var.max_aggregation_interval
  vpc_id                   = var.vpc_id

  dynamic "destination_options" {
    for_each = var.log_destination_type == "s3" ? [true] : []

    content {
      file_format                = var.file_format
      hive_compatible_partitions = var.hive_compatible_partitions
      per_hour_partition         = var.per_hour_partition
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.vpc_flow_log_tags
  )
}

################################################################################
## CLOUDWATCH                                                                 ##
################################################################################
resource "aws_cloudwatch_log_group" "this" {
  count = local.create_cloudwatch_log_group ? 1 : 0

  kms_key_id        = var.log_group_kms_key_id
  name              = format("%s%s", var.log_group_name_prefix, var.vpc_id)
  retention_in_days = var.log_group_retention_in_days

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.vpc_flow_log_tags
  )
}

################################################################################
## IAM                                                                        ##
################################################################################
resource "aws_iam_role" "this" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.cloudwatch_assume_role[0].json

  name_prefix          = "vpc-flow-log-role-"
  permissions_boundary = var.iam_role_permissions_boundary

  tags = merge(
    var.tags,
    var.vpc_flow_log_tags
  )
}

resource "aws_iam_policy" "this" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  name_prefix = "vpc-flow-logs-to-cloudwatch-"
  policy      = data.aws_iam_policy_document.cloudwatch[0].json

  tags = merge(
    var.tags,
    var.vpc_flow_log_tags
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  count = local.create_cloudwatch_iam_role ? 1 : 0

  policy_arn = aws_iam_policy.this[0].arn
  role       = aws_iam_role.this[0].name
}
