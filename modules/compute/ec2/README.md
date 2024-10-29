# AWS EC2 Module

A Terraform module for creating and managing AWS EC2 instances with support for spot instances, auto-scaling groups, and various configuration options.

## Features

- EC2 instance creation with configurable instance types
- Support for spot instances
- Auto Scaling Group integration
- Security group management
- Elastic IP association
- EBS volume management
- Instance metadata configuration
- CloudWatch monitoring integration
- IAM instance profile support

## Usage

### Basic EC2 Instance

```hcl
module "ec2_instance" {
  source = "path/to/modules/compute/ec2"

  # Core Configuration
  name        = "my-instance"
  environment = "dev"

  # Instance Configuration
  ami_id        = "ami-12345678"
  instance_type = "t3.micro"
  key_name      = "my-key-pair"

  # Network Configuration
  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"

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

  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
```

### With Spot Instances

```hcl
module "ec2_spot_instance" {
  source = "path/to/modules/compute/ec2"

  # Enable spot instances
  use_spot_instances = true
  spot_price        = "0.0035"  # Optional: defaults to on-demand price

  # ... other configuration options remain the same
}
```

### With Auto Scaling

```hcl
module "ec2_with_asg" {
  source = "path/to/modules/compute/ec2"

  # Enable auto scaling
  enable_autoscaling = true
  desired_capacity  = 2
  min_size         = 1
  max_size         = 4

  # ... other configuration options remain the same
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name to be used on EC2 instance created | `string` | n/a | yes |
| environment | Environment name | `string` | n/a | yes |
| ami_id | ID of AMI to use for the instance | `string` | n/a | yes |
| instance_type | The type of instance to start | `string` | `"t3.micro"` | no |
| vpc_id | VPC ID where the instance will be created | `string` | n/a | yes |
| subnet_id | VPC Subnet ID to launch in | `string` | n/a | yes |
| key_name | Key name of the Key Pair to use for the instance | `string` | `null` | no |
| create_security_group | Whether to create a security group | `bool` | `true` | no |
| security_group_rules | Security group rules to add to the security group | `object` | `{}` | no |
| root_volume_size | Size of the root volume in gigabytes | `number` | `20` | no |
| root_volume_type | Type of root volume | `string` | `"gp3"` | no |
| enable_cloudwatch_monitoring | Enable CloudWatch detailed monitoring | `bool` | `true` | no |
| enable_ebs_optimization | Enable EBS optimization | `bool` | `null` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | The ID of the instance |
| public_ip | Public IP address of the instance |
| private_ip | Private IP address of the instance |
| security_group_id | ID of the security group |
| elastic_ip | Elastic IP address (if enabled) |
| autoscaling_group_id | The ID of the Auto Scaling Group (if enabled) |

## License

Apache 2 Licensed. See LICENSE for full details.
