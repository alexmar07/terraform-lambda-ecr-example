provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

terraform {
  backend "s3" {
    bucket  = "state-001"
    key     = "state"
    profile = "default"
    region  = "eu-central-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}