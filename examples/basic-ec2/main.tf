module "ec2_instance" {
  source = "../../modules/compute/ec2"

  # Core Configuration
  name        = var.name
  environment = var.environment

  # Instance Configuration
  ami_id        = var.ami_id
  instance_type = var.instance_type

  # Network Configuration
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  # Security Configuration
  create_security_group = true
  security_group_rules = {
    ingress = [
      {
        description = "SSH from anywhere"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ],
    egress = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  # Storage Configuration
  root_volume_size = 20
  root_volume_type = "gp3"

  # Monitoring Configuration
  enable_cloudwatch_monitoring = true

  tags = var.tags
}
