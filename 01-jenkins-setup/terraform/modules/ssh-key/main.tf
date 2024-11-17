
# Read the private key from the parent directory (e.g., ../id_rsa)
data "local_file" "private_key" {
  #filename = path.join(path.module, "../ssh_keys/")
  filename = var.private_key_path
}

data "local_file" "public_key" {
  #filename = path.join(path.module, "../ssh_keys/")
  filename = var.public_key_path
}

resource "aws_ssm_parameter" "ssh_private_key" {
  name        = "/devops-tools/jenkins/id_rsa"
  description = "Jenkins SSH Private Key"
  type        = "SecureString"
  value       = data.local_file.private_key.content
  overwrite   = true
}

resource "aws_ssm_parameter" "ssh_public_key" {
  name        = "/devops-tools/jenkins/id_rsa.pub"
  description = "Jenkins SSH Public Key"
  type        = "SecureString"
  value       = data.local_file.public_key.content
  overwrite   = true
}
