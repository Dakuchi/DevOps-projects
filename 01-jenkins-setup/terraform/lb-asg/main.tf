provider "aws" {
  region = "ap-southeast-1"
}

## Store terraform state in AWS S3 bucker
terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket  = "dakuchi-bucket"
    key     = "terraform/state/jenkins-setup/lb-asg/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true

    # Enable DynamoDB state locking
    dynamodb_table = "terraform-lock"
    #acl            = "bucket-owner-full-control"
  }
}
module "lb-asg" {
  source        = "../modules/lb-asg"
  subnets       = ["subnet-03e9c2019761f5aa2", "subnet-0fa58941cf0f7359e", "subnet-0522d7eee787de945"]
  ami_id        = "ami-083dc2687cf2a1151"
  instance_type = "t2.micro"
  key_name      = "jenkins-key"
  environment   = "dev"
  vpc_id        = "vpc-0bbe6c531595129e0"
}
