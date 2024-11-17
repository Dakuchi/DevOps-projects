packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

variable "ami_id" {
  type    = string
  default = "ami-047126e50991d067b"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0bbe6c531595129e0"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0fa58941cf0f7359e"
}

variable "security_group_ids" {
  type    = string
  default = "sg-0d5314a5b4561a4c5"
}
variable "efs_mount_point" {
  type    = string
  default = ""
}

locals {
  app_name = "jenkins-controller"
}

source "amazon-ebs" "jenkins" {
  ami_name          = local.app_name
  instance_type     = "t2.micro"
  region            = "ap-southeast-1"
  availability_zone = "ap-southeast-1a"
  source_ami        = var.ami_id
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_ids
  associate_public_ip_address = true
  ssh_username      = "ubuntu"
  tags = {
    Env  = "dev"
    Name = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]

  provisioner "ansible" {
    playbook_file   = "ansible/jenkins-controller.yaml"
    extra_arguments = ["--extra-vars", "ami-id=${var.ami_id} efs_mount_point=${var.efs_mount_point}", "--scp-extra-args", "'-O'", "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa"]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}