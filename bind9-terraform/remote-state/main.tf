provider "aws" {
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-bind9-statebucket"
     
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name              = "tf-bind9-state-lock"
  billing_mode      = "PAY_PER_REQUEST"
  hash_key          = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}