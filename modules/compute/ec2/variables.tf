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
    condition = contains([
      "t3.micro", "t3.small", "t3.medium",
      "t3.large", "t3.xlarge", "t3.2xlarge",
      "m5.large", "m5.xlarge", "m5.2xlarge"
    ], var.instance_type)
    error_message = "Instance type must be a valid AWS instance type from the allowed list."
  }
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
  validation {
    condition     = can(regex("^subnet-[a-f0-9]{17}$", var.subnet_id))
    error_message = "Subnet ID must be a valid format (subnet-123456789abcdef01)."
  }
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for sg in var.security_group_ids : can(regex("^sg-[a-f0-9]{17}$", sg))])
    error_message = "All security group IDs must be in valid format (sg-123456789abcdef01)."
  }
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = null
}

variable "instance_profile_arn" {
  description = "IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Size of the root volume in gigabytes"
  type        = number
  default     = 20
  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 16384
    error_message = "Root volume size must be between 8 and 16384 GiB."
  }
}

variable "root_volume_type" {
  description = "Type of root volume"
  type        = string
  default     = "gp3"
  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "sc1", "st1"], var.root_volume_type)
    error_message = "Volume type must be one of: gp2, gp3, io1, io2, sc1, st1."
  }
}

variable "root_volume_kms_key_id" {
  description = "KMS key ID used to encrypt EBS volume"
  type        = string
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
    kms_key_id  = optional(string)
  }))
  default = []
  validation {
    condition = alltrue([
      for v in var.additional_ebs_volumes : (
        v.volume_size >= 1 && v.volume_size <= 16384 &&
        contains(["gp2", "gp3", "io1", "io2", "sc1", "st1"], v.volume_type)
      )
    ])
    error_message = "Volume size must be between 1 and 16384 GiB and type must be one of: gp2, gp3, io1, io2, sc1, st1."
  }
}

variable "user_data" {
  description = "User data to provide when launching the instance"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}

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
      try(contains(["enabled", "disabled"], coalesce(var.metadata_options.http_endpoint, "enabled")), true) &&
      try(contains(["optional", "required"], coalesce(var.metadata_options.http_tokens, "required")), true)
    )
    error_message = "Invalid metadata options configuration."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "Additional tags for the volumes"
  type        = map(string)
  default     = {}
}