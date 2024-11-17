provider "aws" {
  region = var.region
}

# Create VPC and route table
module "vpc_subnet" {
  source            = "../modules/vpc_subnet"
  vpc_cidr_block    = var.vpc_cidr_block
  avail_zone        = var.avail_zone
  subnet_cidr_block = var.subnet_cidr_block
  env_prefix        = var.env_prefix
  #default_route_table_id = aws_vpc.jenkins-vpc.default_route_table_id
}

# Define EC2 Module
/*
module "ec2" {
  source        = "../modules/ec2"
  vpc_id        = module.vpc_subnet.vpc_id
  instance_name = var.instance_name
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name
  #security_group_ids = var.security_group_ids
  instance_count = var.instance_count
  subnet_ids     = var.subnet_ids
}
*/

# Define EFS Module
module "efs" {
  source     = "../modules/efs"
  vpc_id     = module.vpc_subnet.vpc_id
  subnet_ids = module.vpc_subnet.subnet_ids
}

# Define IAM Module
module "iam" {
  source                = "../modules/iam"
  instance_profile_name = "jenkins-instance-profile"
  iam_policy_name       = "jenkins-iam-policy"
  role_name             = "jenkins-role"
}


# Define Load Balancer + Auto Scaling Module
module "lb-asg" {
  source        = "../modules/lb-asg"
  subnets       = module.vpc_subnet.subnet_ids
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = "MyKey"
  environment   = "dev"
  vpc_id        = module.vpc_subnet.vpc_id
}

# Define SSH Key Module
module "ssh_key" {
  source           = "../modules/ssh-key"
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
}
