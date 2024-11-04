# Integration Test for EC2 Module

variables {
  instance_type = "t3.medium"
  ami_id        = "ami-0abcdef1234567890"
  key_name      = "test-key"
}

run "deploy_and_verify_ec2" {
  command = apply

  assert {
    condition     = aws_instance.this.id != ""
    error_message = "EC2 instance was not created successfully."
  }

  assert {
    condition     = aws_instance.this.tags["Environment"] == "development"
    error_message = "EC2 instance does not have the correct environment tag."
  }

  assert {
    condition     = aws_instance.this.key_name == var.key_name
    error_message = "EC2 instance key name does not match the expected value."
  }
}