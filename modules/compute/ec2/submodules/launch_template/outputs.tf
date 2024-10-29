# modules/compute/ec2/submodules/launch_template/outputs.tf

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = try(aws_launch_template.this[0].id, null)
}
