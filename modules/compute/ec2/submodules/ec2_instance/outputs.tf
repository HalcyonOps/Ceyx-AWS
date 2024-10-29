output "instance_id" {
  description = "ID of the EC2 instance"
  value       = [for instance in aws_instance.this : instance.id]
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = [for instance in aws_instance.this : instance.public_ip]
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = [for instance in aws_instance.this : instance.private_ip]
}
