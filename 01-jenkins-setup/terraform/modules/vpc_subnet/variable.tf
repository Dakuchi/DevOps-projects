variable "vpc_cidr_block" {
  description = "The CIDR block for VPC."
}

variable "subnet_cidr_block" {
  description = "The CIDR block (IP range) for the subnet. This determines the IP address range for the subnet."
}

variable "env_prefix" {
  description = "A prefix to be used in resource names to distinguish between different environments (e.g., dev, staging, prod)."
}

