# Instance Details
output "id" {
  description = "The ID of the instance"
  value       = aws_instance.this.id
}

output "arn" {
  description = "The ARN of the instance"
  value       = aws_instance.this.arn
}

output "instance_state" {
  description = "The state of the instance"
  value       = aws_instance.this.instance_state
}

# Network Details
output "private_ip" {
  description = "The private IP address assigned to the instance"
  value       = aws_instance.this.private_ip
}

output "private_dns" {
  description = "The private DNS name assigned to the instance"
  value       = aws_instance.this.private_dns
}

output "public_ip" {
  description = "The public IP address assigned to the instance"
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "The public DNS name assigned to the instance"
  value       = aws_instance.this.public_dns
}

# Security Details
output "security_groups" {
  description = "List of associated security group IDs"
  value       = aws_instance.this.vpc_security_group_ids
}

output "default_security_group_id" {
  description = "ID of the default security group created for the instance"
  value       = try(aws_security_group.default[0].id, null)
}

# Storage Details
output "root_block_device_id" {
  description = "ID of the root EBS volume"
  value       = aws_instance.this.root_block_device[0].volume_id
}

output "ebs_block_devices" {
  description = "List of attached EBS block devices"
  value = [for device in aws_instance.this.ebs_block_device : {
    device_name = device.device_name
    volume_id   = device.volume_id
    volume_size = device.volume_size
    encrypted   = device.encrypted
  }]
}

# Tags
output "tags_all" {
  description = "A map of tags assigned to the instance"
  value       = aws_instance.this.tags_all
}
