provider "aws" {
  region = "ap-southeast-1"
}

## Store terraform state in AWS S3 bucker
terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket  = "dakuchi-bucket"
    key     = "terraform/state/jenkins-setup/ssm/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true

    # Enable DynamoDB state locking
    dynamodb_table = "terraform-lock"
    #acl            = "bucket-owner-full-control" # S3 bucket ACL
  }
}

# Create ssh key on aws ssm
module "ssm" {
  source           = "../modules/ssm"
  private_key_path = "../../id_rsa"
  public_key_path  = "../../id_rsa.pub"
}
