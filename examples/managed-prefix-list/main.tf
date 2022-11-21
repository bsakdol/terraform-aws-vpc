provider "aws" {
  region = "us-east-2"
}

################################################################################
## MANAGED PREFIX LIST                                                        ##
################################################################################
module "vpc_endpoints" {
  source = "../../modules/managed-prefix-list"

  managed_prefix_lists = [
    {
      "name"           = "rfc-1918-1"
      "address_family" = "IPv4"
      "max_entries"    = 2
      "cidr_blocks"    = ["10.0.0.0/8", "172.16.0.0/12"]
    },
    {
      "name"           = "rfc-1918-2"
      "address_family" = "IPv4"
      "max_entries"    = 2
      "cidr_blocks"    = ["192.168.0.0/16", "10.100.0.0/16"]
    },
  ]

  tags = {
    "Environment" = "development"
    "GithubRepo"  = "terraform-aws-vpc"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}
