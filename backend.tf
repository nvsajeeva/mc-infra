terraform {
  backend "s3" {
    bucket  = "meta-carbon-iac"
    key     = "terraform/ghost/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "mc"
  }
}
