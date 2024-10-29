# modules/compute/ec2/submodules/spot_instance/variables.tf

variable "use_spot_instances" {
  description = "Flag to use spot instances"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "AMI ID for the spot instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the spot instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the spot instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "Key name for the instance"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  type        = string
  default     = null
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

variable "spot_price" {
  description = "Maximum spot price to bid"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data to provide when launching the instance"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Base64 encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "cpu_credits" {
  description = "Credit specification for CPU usage (standard or unlimited)"
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

variable "additional_ebs_volumes" {
  description = "Additional EBS volumes to attach to the instance"
  type = list(object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    iops                  = number
    throughput            = number
    kms_key_id            = string
    delete_on_termination = bool
  }))
  default = []
}

variable "volume_tags" {
  description = "Tags to apply to the EBS volumes"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the spot instance"
  type        = map(string)
  default     = {}
}