provider "aws" {
  region = local.region
}

locals {
  name   = "vpc-flow-log-example-useast2"
  region = "us-east-2"
}

################################################################################
## VPC                                                                        ##
################################################################################
module "vpc" {
  source = "../../"

  name = local.name

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnets = {
    "10.0.10.0/24" = {
      "availability_zone" = "${local.region}a"
    },
  }

  public_subnets = {
    "10.0.20.0/24" = {
      "availability_zone"  = "${local.region}a"
      "create_nat_gateway" = true
    },
  }

  tags = {
    Environment = "development"
    GithubRepo  = "terraform-aws-vpc"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}

################################################################################
## VPC ENDPOINTS                                                              ##
################################################################################
module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.vpc.id

  endpoints = {
    s3 = {
      route_table_ids   = [for k, v in module.vpc.route_tables.private : v.id]
      vpc_endpoint_type = "Gateway"
    },
  }

  tags = {
    "Environment" = "development"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}

################################################################################
## VPC FLOW LOGS                                                              ##
################################################################################
module "vpc_flow_logs_default" {
  source = "../../modules/vpc-flow-logs"

  log_destination_type = "s3"
  log_destination_arn  = aws_s3_bucket.this.arn

  vpc_id = module.vpc.id

  tags = {
    "Environment" = "development"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}
