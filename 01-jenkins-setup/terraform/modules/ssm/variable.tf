provider "aws" {
  region = "ap-southeast-1"
}

variable "private_key_path" {
  description = " Path to the SSH private key"
  type        = string
  default     = "../../../id_rsa"
}

variable "public_key_path" {
  description = " Path to the SSH public key"
  type        = string
  default     = "../../../id_rsa.pub"
}
