output "efs_mount_point" {
  description = "The EFS mount point name"
  value = [for mt in aws_efs_mount_target.jenkins : mt.dns_name]
}
