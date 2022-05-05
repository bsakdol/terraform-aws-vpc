provider "aws" {
  region = local.region
}

locals {
  name   = "vpc-complete-example"
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

  dhcp_options = {
    domain_name         = "example.local"
    domain_name_servers = ["1.1.1.1", "8.8.8.8"]
    ntp_servers         = ["119.28.183.184", "156.106.214.52"]
  }

  vpc_ipv4_cidr_block_associations = {
    "10.1.0.0/24" = {
      ipv4_cidr_block = "10.1.0.0/24"
      timeouts = {
        create = "15m"
        delete = "15m"
      }
    }
  }

  internal_subnets = {
    "10.0.20.0/24" = {
      "availability_zone" = "${local.region}a"
    },
    "10.0.21.0/24" = {
      "availability_zone" = "${local.region}b"
    },
    "10.0.22.0/24" = {
      "availability_zone" = "${local.region}c"
    },
  }

  private_subnets = {
    "10.0.30.0/24" = {
      "availability_zone" = "${local.region}a"
    },
    "10.0.31.0/24" = {
      "availability_zone" = "${local.region}b"
    },
    "10.0.32.0/24" = {
      "availability_zone" = "${local.region}c"
    },
  }

  public_subnets = {
    "10.0.40.0/24" = {
      "availability_zone"  = "${local.region}a"
      "create_nat_gateway" = true
    },
    "10.0.41.0/24" = {
      "availability_zone"  = "${local.region}b"
      "create_nat_gateway" = true
    },
    "10.0.42.0/24" = {
      "availability_zone"  = "${local.region}c"
      "create_nat_gateway" = true
    },
  }

  network_acl_internal_egress = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }

  network_acl_internal_ingress = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }

  network_acl_private_egress = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }

  network_acl_private_ingress = {
    "100" = {
      "cidr_block"  = "10.0.0.0/8"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    },
    "110" = {
      "cidr_block"  = "172.16.0.0/12"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    },
    "120" = {
      "cidr_block"  = "192.168.0.0/16"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    },
  }

  network_acl_public_egress = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }

  network_acl_public_ingress = {
    "100" = {
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = "0"
      "protocol"    = "-1"
      "rule_action" = "allow"
      "to_port"     = "0"
    }
  }

  tags = {
    "Environment" = "dev"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}

################################################################################
## VPC ENDPOINTS                                                              ##
################################################################################
module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.vpc.id

  endpoint_defaults = {
    private_dns_enabled = true
    route_table_ids     = [for k, v in module.vpc.route_tables.private : v.id]
    security_group_ids  = [data.aws_security_group.default.id]
    subnet_ids          = [for k, v in module.vpc.subnets.private : v.id]

    timeouts = {
      create = "10m"
      update = "10m"
      delete = "10m"
    }
  }

  endpoints = {
    codedeploy = {
      vpc_endpoint_type = "Interface"
    },
    dynamodb = {
      vpc_endpoint_type = "Gateway"
      policy            = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
    },
    ecs = {
      vpc_endpoint_type = "Interface"
    },
    ecs-telemetry = {
      vpc_endpoint_type = "Interface"
    },
    lambda = {
      vpc_endpoint_type = "Interface"
    },
    s3 = {
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
## DEPENDENCIES                                                               ##
################################################################################

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.id
}

data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    actions = [
      "dynamodb:*",
    ]

    effect = "Deny"

    resources = [
      "*"
    ]

    condition {
      test     = "StringNotEquals"
      values   = [module.vpc.id]
      variable = "aws:sourceVpce"
    }

    principals {
      identifiers = ["*"]
      type        = "*"
    }
  }
}
