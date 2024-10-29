resource "aws_instance" "this" {
  count = var.enable_autoscaling ? 0 : 1

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.instance_profile_arn
  monitoring                  = var.enable_cloudwatch_monitoring
  ebs_optimized               = var.enable_ebs_optimization
  placement_group             = var.placement_group

  user_data        = var.user_data
  user_data_base64 = var.user_data_base64

  credit_specification {
    cpu_credits = var.cpu_credits
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  instance_initiated_shutdown_behavior = "terminate"

  lifecycle {
    precondition {
      condition     = length(var.security_group_ids) > 0
      error_message = "At least one security group must be associated with the instance."
    }
    precondition {
      condition     = var.user_data == null || var.user_data_base64 == null
      error_message = "Cannot specify both user_data and user_data_base64."
    }
  }

  tags = var.tags

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = var.root_volume_encrypted
  }
}
