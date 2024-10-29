# modules/compute/ec2/main.tf

# Security Group Creation (Optional)
module "security_group" {
  source = "./submodules/security_group"

  name                  = var.name
  vpc_id                = var.vpc_id
  create_security_group = var.create_security_group
  security_group_rules  = var.security_group_rules
  environment           = var.environment
}

# Launch Template for Auto Scaling (Optional)
module "launch_template" {
  source = "./submodules/launch_template"

  name                         = var.name
  enable_autoscaling           = var.enable_autoscaling
  ami_id                       = var.ami_id
  instance_type                = var.instance_type
  key_name                     = var.key_name
  subnet_id                    = var.subnet_id
  associate_public_ip_address  = var.associate_public_ip_address
  security_group_ids           = module.security_group.security_group_id
  instance_profile_arn         = var.instance_profile_arn
  root_volume_size             = var.root_volume_size
  root_volume_type             = var.root_volume_type
  root_volume_kms_key_id       = var.root_volume_kms_key_id
  metadata_options             = var.metadata_options
  enable_cloudwatch_monitoring = var.enable_cloudwatch_monitoring
  enable_ebs_optimization      = var.enable_ebs_optimization
  tags                         = local.tags
}

# Auto Scaling Group (Optional)
module "autoscaling_group" {
  source = "./submodules/autoscaling_group"

  name               = var.name
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size
  max_size           = var.max_size
  subnet_ids         = var.subnet_ids
  launch_template_id = module.launch_template.launch_template_id
}

# EC2 Instance (if Auto Scaling is not enabled)
module "ec2_instance" {
  source = "./submodules/ec2_instance"

  ami_id                       = var.ami_id
  instance_type                = var.instance_type
  subnet_id                    = var.subnet_id
  security_group_ids           = local.security_group_ids
  key_name                     = var.key_name
  instance_profile_arn         = var.instance_profile_arn
  root_volume_size             = var.root_volume_size
  root_volume_type             = var.root_volume_type
  root_volume_kms_key_id       = var.root_volume_kms_key_id
  user_data                    = var.user_data
  user_data_base64             = var.user_data_base64
  associate_public_ip_address  = var.associate_public_ip_address
  enable_cloudwatch_monitoring = var.enable_cloudwatch_monitoring
  enable_ebs_optimization      = var.enable_ebs_optimization
  placement_group              = var.placement_group
  cpu_credits                  = var.cpu_credits
  metadata_options             = var.metadata_options
  tags                         = local.tags
  enable_provisioners          = var.enable_provisioners
  provisioner_commands         = var.provisioner_commands
  ssh_user                     = var.ssh_user
  ssh_private_key              = var.ssh_private_key
}

# Elastic IP Allocation (Optional)
module "elastic_ip" {
  source = "./submodules/elastic_ip"

  allocate_elastic_ip = var.allocate_elastic_ip
  tags                = local.tags
}

# Spot Instance Request (if using spot instances)
module "spot_instance" {
  source = "./submodules/spot_instance"
  count  = var.create_spot_instance ? 1 : 0

  use_spot_instances           = var.use_spot_instances
  ami_id                       = var.ami_id
  instance_type                = var.instance_type
  subnet_id                    = var.subnet_id
  security_group_ids           = module.security_group.security_group_id
  key_name                     = var.key_name
  associate_public_ip_address  = var.associate_public_ip_address
  instance_profile_arn         = var.instance_profile_arn
  enable_cloudwatch_monitoring = var.enable_cloudwatch_monitoring
  enable_ebs_optimization      = var.enable_ebs_optimization
  spot_price                   = var.spot_price
  user_data                    = var.user_data
  user_data_base64             = var.user_data_base64
  cpu_credits                  = var.cpu_credits
  root_volume_size             = var.root_volume_size
  root_volume_type             = var.root_volume_type
  root_volume_kms_key_id       = var.root_volume_kms_key_id
  additional_ebs_volumes       = var.additional_ebs_volumes
  volume_tags                  = local.volume_tags
  tags                         = local.tags
}
