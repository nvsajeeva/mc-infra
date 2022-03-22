terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
  profile = "mc"
}

data "aws_availability_zones" "available" {}

provider "http" {}
