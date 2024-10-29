# modules/compute/ec2/submodules/autoscaling_group/outputs.tf

output "autoscaling_group_id" {
  description = "ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.id
}