# modules/compute/ec2/submodules/elastic_ip/outputs.tf

output "elastic_ip_id" {
  description = "The ID of the Elastic IP"
  value       = try(aws_eip.this[0].id, null)
}

output "elastic_ip_address" {
  description = "The public IP address of the Elastic IP"
  value       = try(aws_eip.this[0].public_ip, null)
}
