provider "aws" {
  region = "ap-southeast-1"
}

## Store terraform state in AWS S3 bucker
terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket  = "dakuchi-bucket"
    key     = "terraform/state/jenkins-setup/jenkins-agent/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true

    # Enable DynamoDB state locking
    dynamodb_table = "terraform-lock"
    #acl            = "bucket-owner-full-control"
  }
}

module "ec2_instance" {
  source = "../modules/ec2"

  instance_name  = "jenkins-agent"
  ami_id         = "ami-00c510463461bc88f"
  vpc_id         = "vpc-0bbe6c531595129e0"
  instance_type  = "t2.micro"
  key_name       = "jenkins-agent"
  subnet_ids     = ["subnet-03e9c2019761f5aa2", "subnet-0fa58941cf0f7359e", "subnet-0522d7eee787de945"]
  instance_count = 1
}
