terraform {
    backend "s3" {
        bucket = "tfstate-telegram-contable-bot"
        key    = "terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "for_state_lock"
        encrypt = "true"
    }
}

provider "aws" {
  region = var.region
  allowed_account_ids = var.allowed_account_ids
  version = "~> 4.19.0"
  default_tags {
    tags = {
      Environment = var.Environment
      Owner       = var.Owner
      Company     = var.Company
    }
  }
}