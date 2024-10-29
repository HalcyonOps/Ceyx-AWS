# modules/compute/ec2/submodules/spot_instance/outputs.tf

output "spot_instance_id" {
  description = "The ID of the spot instance request"
  value       = try(aws_spot_instance_request.this[0].id, null)
}

output "spot_instance_public_ip" {
  description = "The public IP of the spot instance"
  value       = try(aws_spot_instance_request.this[0].public_ip, null)
}
