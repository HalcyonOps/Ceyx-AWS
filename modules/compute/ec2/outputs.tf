# modules/compute/ec2/outputs.tf

# Instance Information
output "instance_id" {
  description = "The ID of the instance"
  value       = try(module.ec2_instance[0].instance_id, "")
}

output "instance_state" {
  description = "The state of the instance"
  value       = try(module.ec2_instance[0].instance_state, "")
}

output "availability_zone" {
  description = "The AZ where the instance is deployed"
  value       = try(module.ec2_instance[0].availability_zone, "")
}

# Network Information
output "private_ip" {
  description = "Private IP address assigned to the instance"
  value       = try(module.ec2_instance[0].private_ip, "")
}

output "public_ip" {
  description = "Public IP address assigned to the instance"
  value       = try(module.ec2_instance[0].public_ip, "")
}

output "elastic_ip" {
  description = "Elastic IP address assigned to the instance (if enabled)"
  value       = var.allocate_elastic_ip ? module.elastic_ip[0].elastic_ip_address : null
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = try(module.ec2_instance[0].primary_network_interface_id, "")
}

# Security Information
output "security_group_ids" {
  description = "List of security group IDs attached to the instance"
  value       = local.security_group_ids
}

# Instance Configuration
output "instance_metadata_options" {
  description = "The metadata options of the instance"
  value       = try(module.ec2_instance[0].metadata_options, {})
}

# Auto Scaling Information
output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling Group (if enabled)"
  value       = var.enable_autoscaling ? module.autoscaling_group[0].asg_id : null
}

output "launch_template_id" {
  description = "The ID of the launch template (if auto scaling is enabled)"
  value       = var.enable_autoscaling ? module.launch_template[0].launch_template_id : null
}

# Tags
output "tags_all" {
  description = "A map of tags assigned to all resources"
  value       = local.tags
}
