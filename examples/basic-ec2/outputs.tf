output "instance_id" {
  description = "The ID of the instance"
  value       = module.ec2_instance.id
}

output "instance_private_ip" {
  description = "The private IP address of the instance"
  value       = module.ec2_instance.private_ip
}

output "root_volume_id" {
  description = "The volume ID of the root device"
  value       = module.ec2_instance.root_block_device_volume_id
} 