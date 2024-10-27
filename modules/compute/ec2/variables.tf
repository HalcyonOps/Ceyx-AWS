# Instance Configuration
variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  validation {
    condition     = length(var.name) > 3 && length(var.name) <= 128 && can(regex("^[a-zA-Z0-9-_]+$", var.name))
    error_message = "Name must be between 3 and 128 characters, and can only contain letters, numbers, hyphens, and underscores."
  }
}

variable "ami_id" {
  description = "ID of AMI to use for the instance"
  type        = string
  validation {
    condition     = can(regex("^ami-[a-f0-9]{17}$", var.ami_id))
    error_message = "AMI ID must be a valid format (ami-123456789abcdef01)."
  }
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
  validation {
    condition = can(regex("^[a-z][1-9][.][a-z0-9]+$", var.instance_type)) && contains([
      "t3.micro", "t3.small", "t3.medium",
      "t3.large", "t3.xlarge", "t3.2xlarge",
      "m5.large", "m5.xlarge", "m5.2xlarge",
      # Add more as needed
    ], var.instance_type)
    error_message = "Instance type must be a valid AWS instance type."
  }
}

variable "environment" {
  description = "Environment where the instance will be deployed"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

# Network Configuration
variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  validation {
    condition     = can(regex("^subnet-[a-f0-9]{17}$", var.subnet_id))
    error_message = "Subnet ID must be a valid format (subnet-123456789abcdef01)."
  }
}

variable "vpc_id" {
  description = "The VPC ID where the instance will be created"
  type        = string
  validation {
    condition     = can(regex("^vpc-[a-f0-9]{17}$", var.vpc_id))
    error_message = "VPC ID must be a valid format (vpc-123456789abcdef01)."
  }
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "A list of existing security group IDs to associate with"
  type        = list(string)
  default     = []
  validation {
    condition = length(var.security_group_ids) > 0 || var.create_security_group
    error_message = "Either provide security group IDs or set create_security_group to true."
  }
}

# Security Configuration
variable "create_security_group" {
  description = "Whether to create a security group for the instance"
  type        = bool
  default     = true
}

variable "security_group_rules" {
  description = "Map of security group rules to apply when create_security_group is true"
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = {}
  validation {
    condition = alltrue([
      for k, v in var.security_group_rules : (
        contains(["ingress", "egress"], v.type) &&
        v.from_port >= -1 && v.from_port <= 65535 &&
        v.to_port >= -1 && v.to_port <= 65535 &&
        contains(["tcp", "udp", "icmp", "-1"], v.protocol) &&
        length(v.description) <= 255
      )
    ])
    error_message = "Invalid security group rule configuration."
  }
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = null
}

# Storage Configuration
variable "root_volume_size" {
  description = "Size of the root volume in gigabytes"
  type        = number
  default     = 20
  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 16384
    error_message = "Root volume size must be between 8 and 16384 GB."
  }
}

variable "root_volume_type" {
  description = "Type of root volume. Can be standard, gp2, gp3, or io1"
  type        = string
  default     = "gp3"
  validation {
    condition     = contains(["standard", "gp2", "gp3", "io1"], var.root_volume_type)
    error_message = "Root volume type must be one of: standard, gp2, gp3, or io1."
  }
}

variable "root_volume_iops" {
  description = "Amount of provisioned IOPS. Only valid for volume_type of io1 or gp3"
  type        = number
  default     = null
  validation {
    condition     = var.root_volume_iops == null || (var.root_volume_iops >= 3000 && var.root_volume_iops <= 64000)
    error_message = "IOPS must be between 3000 and 64000 when specified."
  }
}

variable "root_volume_throughput" {
  description = "Throughput in MiB/s. Only valid for volume_type of gp3"
  type        = number
  default     = null
}

variable "additional_ebs_volumes" {
  description = "Additional EBS volumes to attach to the instance"
  type = list(object({
    device_name = string
    volume_size = number
    volume_type = string
    iops        = optional(number)
    throughput  = optional(number)
    encrypted   = optional(bool, true)
    kms_key_id  = optional(string)
  }))
  default = []
}

# IAM Configuration
variable "create_iam_instance_profile" {
  description = "Whether to create an IAM instance profile"
  type        = bool
  default     = false
}

variable "iam_role_policies" {
  description = "List of IAM policies ARNs to attach to the IAM role"
  type        = list(string)
  default     = []
}

# Monitoring Configuration
variable "enable_detailed_monitoring" {
  description = "If true, detailed monitoring will be enabled"
  type        = bool
  default     = false
}

variable "enable_ssm_management" {
  description = "Enable AWS Systems Manager Session Manager access"
  type        = bool
  default     = true
}

# User Data Configuration
variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data"
  type        = string
  default     = null
}

# Metadata Options
variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "required")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string, "enabled")
  })
  default = {}
  validation {
    condition = (
      contains(["enabled", "disabled"], coalesce(var.metadata_options.http_endpoint, "enabled")) &&
      contains(["optional", "required"], coalesce(var.metadata_options.http_tokens, "required")) &&
      coalesce(var.metadata_options.http_put_response_hop_limit, 1) >= 1 &&
      coalesce(var.metadata_options.http_put_response_hop_limit, 1) <= 64 &&
      contains(["enabled", "disabled"], coalesce(var.metadata_options.instance_metadata_tags, "enabled"))
    )
    error_message = "Invalid metadata options configuration."
  }
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
  validation {
    condition     = length(var.tags) <= 50
    error_message = "AWS allows a maximum of 50 tags per resource."
  }
}

variable "volume_tags" {
  description = "A map of tags to add to all volumes"
  type        = map(string)
  default     = {}
}
