provider "aws" {
  region  = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
  backend "s3" {
    bucket         = "tf-state-lakshmi"
    key            = "global/s3/terraform.tfstate"
	#key is the path in which tfstate is getting saved
	encrypt        = true
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}

#create s3 buxket
resource "aws_s3_bucket" "tf-state-bucket" {
  bucket = "tf-state-lakshmi"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  } 
}

#create dynamodb table
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}



