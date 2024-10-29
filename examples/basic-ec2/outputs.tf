output "instance_id" {
  description = "The ID of the instance"
  value       = module.ec2_instance.instance_id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = module.ec2_instance.public_ip
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = module.ec2_instance.private_ip
}

output "security_group_ids" {
  description = "List of security group IDs"
  value       = module.ec2_instance.security_group_ids
}
