provider "aws" {
  region     = "us-east-2"
}

resource "aws_s3_bucket" "s3_tfstate" {
    bucket = "tfstate-telegram-contable-bot"
    acl = "private"
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "for_state_lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}