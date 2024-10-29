# modules/compute/ec2/main.tf

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = var.subnet_id
  vpc_security_group_ids     = var.security_group_ids
  key_name                   = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile       = var.instance_profile_arn
  monitoring                 = var.enable_detailed_monitoring
  user_data                  = var.user_data
  user_data_base64          = var.user_data_base64

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = true
    kms_key_id  = var.root_volume_kms_key_id
    tags        = merge(local.tags, var.volume_tags)
  }

  dynamic "ebs_block_device" {
    for_each = var.additional_ebs_volumes
    content {
      device_name = ebs_block_device.value.device_name
      volume_size = ebs_block_device.value.volume_size
      volume_type = ebs_block_device.value.volume_type
      iops        = ebs_block_device.value.iops
      throughput  = ebs_block_device.value.throughput
      encrypted   = true
      kms_key_id  = ebs_block_device.value.kms_key_id
      tags        = merge(local.tags, var.volume_tags)
    }
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  tags = local.tags

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
}
