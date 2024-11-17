provider "aws" {
  region = "ap-southeast-1"
}

## Store terraform state in AWS S3 bucker
terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket  = "dakuchi-bucket"
    key     = "terraform/state/jenkins-setup/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true

    # Enable DynamoDB state locking
    dynamodb_table = "terraform-lock"
    #acl            = "bucket-owner-full-control" # S3 bucket ACL

    # Optionally, you can use `profile` for a specific IAM profile
    # profile = "my-profile"

    # Versioning and other advanced settings can be enabled as needed
  }
}

# Create Jenkins controller
