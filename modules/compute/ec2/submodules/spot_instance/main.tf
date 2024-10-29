# modules/compute/ec2/submodules/spot_instance/main.tf

resource "aws_spot_instance_request" "this" {
  count = var.use_spot_instances ? 1 : 0

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.instance_profile_arn
  monitoring                  = var.enable_cloudwatch_monitoring
  ebs_optimized               = var.enable_ebs_optimization
  spot_price                  = var.spot_price
  wait_for_fulfillment        = true
  instance_interruption_behavior = "terminate"

  user_data         = var.user_data
  user_data_base64  = var.user_data_base64

  credit_specification {
    cpu_credits = var.cpu_credits
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = true
    kms_key_id  = var.root_volume_kms_key_id
    tags        = var.volume_tags
  }

  dynamic "ebs_block_device" {
    for_each = var.additional_ebs_volumes
    content {
      device_name           = ebs_block_device.value.device_name
      volume_size           = ebs_block_device.value.volume_size
      volume_type           = ebs_block_device.value.volume_type
      iops                  = ebs_block_device.value.iops
      throughput            = ebs_block_device.value.throughput
      encrypted             = true
      kms_key_id            = ebs_block_device.value.kms_key_id
      delete_on_termination = ebs_block_device.value.delete_on_termination
      tags                  = var.volume_tags
    }
  }

  tags = var.tags
}