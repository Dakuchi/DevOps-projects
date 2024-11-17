provider "aws" {
  region = "ap-southeast-1"
}

## Store terraform state in AWS S3 bucker
terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket  = "dakuchi-bucket"
    key     = "terraform/state/jenkins-setup/vpc_subnet/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true

    # Enable DynamoDB state locking
    dynamodb_table = "terraform-lock"
    #acl            = "bucket-owner-full-control" # S3 bucket ACL
  }
}

module "vpc_subnet" {
  source            = "../modules/vpc_subnet"
  vpc_cidr_block    = "10.0.0.0/16"
  subnet_cidr_block = "10.0.0.0/16"
  env_prefix        = "jenkins"
}
