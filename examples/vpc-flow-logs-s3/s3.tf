data "aws_iam_policy_document" "vpc_flow_log_s3" {
  statement {
    sid = "AWSLogDeliveryWrite"

    actions = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    resources = ["arn:aws:s3:::${local.s3_bucket_name}/AWSLogs/*"]
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"

    actions = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    resources = ["arn:aws:s3:::${local.s3_bucket_name}"]
  }
}

locals {
  s3_bucket_name = format("%s-%s", "vpc-flow-logs-to-s3", random_integer.s3.id)
}

resource "random_integer" "s3" {
  min = 5
  max = 10
}

resource "aws_s3_bucket" "this" {
  bucket              = local.s3_bucket_name
  force_destroy       = true
  object_lock_enabled = false

  tags = {
    Environment = "development"
    GithubRepo  = "terraform-aws-vpc"
    Name        = local.s3_bucket_name
    Owner       = "bsakdol"
    Terraform   = "true"
  }

  lifecycle {
    ignore_changes = [
      acceleration_status,
      acl,
      grant,
      cors_rule,
      force_destroy,
      lifecycle_rule,
      logging,
      object_lock_configuration,
      policy,
      replication_configuration,
      request_payer,
      server_side_encryption_configuration,
      versioning,
      website
    ]
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.vpc_flow_log_s3.json
}
