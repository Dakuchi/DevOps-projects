variable "vpc_id" {
  description = "Specifies the VPC id to attach"
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

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where the EC2 instance(s) will be launched."
}
