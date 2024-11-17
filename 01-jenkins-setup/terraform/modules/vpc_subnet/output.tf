output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.jenkins-vpc.id
}
/*
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.jenkins-subnet-1.id
}
*/

# Output the subnet IDs for each Availability Zone
output "subnet_ids" {
  description = "List of subnet IDs for each Availability Zone"
  value       = [for subnet in aws_subnet.jenkins-subnet : subnet.id]
}
