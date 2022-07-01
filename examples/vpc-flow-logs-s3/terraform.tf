terraform {
  required_version = ">= 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.3"
    }
  }
}
