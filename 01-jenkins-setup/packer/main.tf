provider "packer" {}

resource "packer_build" "jenkins_ami" {
  template = "${path.module}/packer-jenkins.hcl"
}

output "ami_id" {
  value = packer_build.jenkins_ami.id
}
