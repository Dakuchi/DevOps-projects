provider "aws" {
  region = "ap-southeast-1"
}

## Store terraform state in AWS S3 bucker
terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket  = "dakuchi-bucket"
    key     = "terraform/state/jenkins-setup/efs/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true

    # Enable DynamoDB state locking
    dynamodb_table = "terraform-lock"
    #acl            = "bucket-owner-full-control"
  }
}


data "aws_vpc" "jenkins-vpc" {
  filter {
    name   = "tag:Name"
    values = ["jenkins*"]
  }
}

# Data source to get the list of Availability Zones
data "aws_availability_zones" "available" {}

# Data source to get subnets based on tags and availability zone
data "aws_subnets" "jenkins_subnets" {
  filter {
    name   = "tag:Name"
    values = ["jenkins*"]
  }

  filter {
    name   = "availabilityZone"
    values = data.aws_availability_zones.available.names
  }
}

# Output the subnet IDs
output "subnet_ids" {
  value = data.aws_subnets.jenkins_subnets
}

output "vpc_id" {
  value = data.aws_vpc.jenkins-vpc
}

module "efs_module" {
  source     = "../modules/efs"
  vpc_id     = data.aws_vpc.jenkins-vpc.id
  subnet_ids = data.aws_subnets.jenkins_subnets.ids
}


