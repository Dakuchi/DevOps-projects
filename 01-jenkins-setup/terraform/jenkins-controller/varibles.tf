variable "region" {
  description = "The region for resources."
}

variable "environment" {
  description = "The environment variable."
}

variable "vpc_cidr_block" {
  description = "The CIDR block for VPC."
}

variable "avail_zone" {
  description = "The AWS Availability Zone in which the subnet will be created."
}

variable "subnet_cidr_block" {
  description = "The CIDR block (IP range) for the subnet. This determines the IP address range for the subnet."
}

variable "env_prefix" {
  description = "A prefix to be used in resource names to distinguish between different environments (e.g., dev, staging, prod)."
}

variable "instance_name" {
  type        = string
  description = "Specifies the name of the EC2 instance that will be created."
  default     = "my-instance"
}

variable "ami_id" {
  type        = string
  description = "The Amazon Machine Image (AMI) ID used to launch the EC2 instance."
  default     = "ami-047126e50991d067b"
}

variable "instance_type" {
  type        = string
  description = "Specifies the type of EC2 instance to launch, which determines the compute capacity (e.g., CPU, RAM)"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "The name of the SSH key pair that will be used to access the EC2 instance."
  default     = "MyKey"
}

variable "instance_count" {
  type        = number
  description = "Specifies the number of EC2 instances to launch."
  default     = 1
}

/*
variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where the EC2 instance(s) will be launched."
}
*/

variable "subnets" {
  description = "Subnets for Load Balancer + Auto Scaling Module."
}

variable "private_key_path" {
  description = "Path to the private key."
}

variable "public_key_path" {
  description = "Path to the public key."
}

