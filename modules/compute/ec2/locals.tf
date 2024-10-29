locals {
  create = var.create && !var.create_spot_instance

  ami_id = coalesce(var.ami_id, try(data.aws_ami.this[0].id, null))

  is_t_instance_type = can(regex("^t[23]", var.instance_type))

  ebs_optimized = coalesce(
    var.ebs_optimized,
    data.aws_ec2_instance_type.selected.ebs_optimized_support != "unsupported"
  )

  tags = merge(
    {
      Name        = var.name
      Module      = "ceyx/compute/ec2"
      Environment = var.environment
      Managed_By  = "terraform"
      Created_At  = timestamp()
    },
    var.tags
  )

  volume_tags = merge(
    local.tags,
    var.volume_tags
  )

  security_group_ids = var.create_security_group ? [module.security_group.security_group_id[0]] : var.vpc_security_group_ids
}
