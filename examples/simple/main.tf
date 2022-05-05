provider "aws" {
  region = local.region
}

locals {
  name   = "simple-vpc-example"
  region = "us-east-2"
}

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
    "10.0.11.0/24" = {
      "availability_zone" = "${local.region}b"
    }
  }

  public_subnets = {
    "10.0.20.0/24" = {
      "availability_zone"  = "${local.region}a"
      "create_nat_gateway" = true
    },
    "10.0.21.0/24" = {
      "availability_zone"  = "${local.region}b"
      "create_nat_gateway" = true
    }
  }

  tags = {
    Environment = "development"
    GithubRepo  = "terraform-aws-vpc"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}
