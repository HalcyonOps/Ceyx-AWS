locals {
  tags = merge(
    var.tags,
    {
      Name        = var.name
      Module      = "ceyx/compute/ec2"
      Environment = var.environment
      Managed_By  = "terraform"
    }
  )

  create_sg = var.create_security_group && length(var.security_group_ids) == 0
  security_group_ids = local.create_sg ? [aws_security_group.default[0].id] : var.security_group_ids

  default_egress_rules = {
    all = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_security_group" "default" {
  count       = local.create_sg ? 1 : 0
  name_prefix = "${var.name}-sg"
  vpc_id      = var.vpc_id
  description = "Security group for ${var.name} EC2 instance"

  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = local.default_egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(local.tags, {
    Name = "${var.name}-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = var.subnet_id
  vpc_security_group_ids     = local.security_group_ids
  key_name                   = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  
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

  dynamic "credit_specification" {
    for_each = can(regex("^t[0-9]", var.instance_type)) ? [1] : []
    content {
      cpu_credits = var.cpu_credits
    }
  }

  user_data = var.user_data
  user_data_base64 = var.user_data_base64

  tags = local.tags

  lifecycle {
    precondition {
      condition     = length(local.security_group_ids) > 0
      error_message = "At least one security group must be associated with the instance."
    }

    precondition {
      condition     = var.user_data == null || var.user_data_base64 == null
      error_message = "Cannot specify both user_data and user_data_base64."
    }
  }
}
