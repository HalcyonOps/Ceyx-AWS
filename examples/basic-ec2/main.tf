provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.vpc_cidr

  azs             = ["${var.region}a"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = var.tags
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = var.tags
}

module "ec2_instance" {
  source = "../../modules/compute/ec2"

  name                        = var.name
  ami_id                      = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = module.vpc.private_subnets[0]
  security_group_ids         = [module.security_group.security_group_id]
  associate_public_ip_address = false

  root_volume_size = 30
  root_volume_type = "gp3"

  additional_ebs_volumes = [
    {
      device_name = "/dev/sdf"
      volume_size = 50
      volume_type = "gp3"
    }
  ]

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  environment = "dev"
  tags        = var.tags
} 