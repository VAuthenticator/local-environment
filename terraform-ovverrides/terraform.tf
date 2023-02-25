terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

provider "aws" {
  region              = "us-east-1"

  endpoints {
    iam      = "http://localhost:4566"
    sts      = "http://localhost:4566"
    s3       = "http://localhost:4566"
    s3api    = "http://localhost:4566"
    kms      = "http://localhost:4566"
    dynamodb = "http://localhost:8000"
  }
}