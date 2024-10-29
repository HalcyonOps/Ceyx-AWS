# modules/compute/ec2/submodules/launch_template/variables.tf

variable "name" {
  description = "Name prefix for the launch template"
  type        = string
}

variable "enable_autoscaling" {
  description = "Flag to enable autoscaling"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "AMI ID for the launch template"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the launch template"
  type        = string
}

variable "key_name" {
  description = "Key name for the instance"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID for the network interface"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Size of the root EBS volume"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp2"
}

variable "root_volume_kms_key_id" {
  description = "KMS key ID for the root EBS volume encryption"
  type        = string
  default     = null
}

variable "metadata_options" {
  description = "Metadata options for the instance"
  type = object({
    http_endpoint               = string
    http_tokens                 = string
    http_put_response_hop_limit = number
    instance_metadata_tags      = string
  })
  default = {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }
}

variable "enable_cloudwatch_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = false
}

variable "enable_ebs_optimization" {
  description = "Enable EBS optimization for the instance"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the launch template"
  type        = map(string)
  default     = {}
}

variable "maintenance_options" {
  description = "Maintenance options for the instance"
  type = object({
    auto_recovery = string
  })
  default = null
  validation {
    condition     = var.maintenance_options == null || try(contains(["default", "disabled"], var.maintenance_options.auto_recovery), true)
    error_message = "Maintenance options auto_recovery must be either 'default' or 'disabled'."
  }
}

variable "capacity_reservation_specification" {
  description = "Capacity reservation specification for the instance"
  type = object({
    capacity_reservation_preference = string
  })
  default = null
  validation {
    condition     = var.capacity_reservation_specification == null || try(contains(["open", "none"], var.capacity_reservation_specification.capacity_reservation_preference), true)
    error_message = "Capacity reservation preference must be either 'open' or 'none'."
  }
}
