variable "ami_id" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
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
}

variable "root_volume_type" {
  description = "Type of root volume"
  type        = string
  default     = "gp3"
}

variable "root_volume_kms_key_id" {
  description = "KMS key ID for the root EBS volume encryption"
  type        = string
  default     = null
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

variable "placement_group" {
  description = "The name of the placement group to associate with the instance"
  type        = string
  default     = null
}

variable "cpu_credits" {
  description = "Credit specification for CPU usage (standard or unlimited)"
  type        = string
  default     = null
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
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_provisioners" {
  description = "Enable provisioners for the instance"
  type        = bool
  default     = false
}

variable "provisioner_commands" {
  description = "Commands to run in provisioners"
  type        = list(string)
  default     = []
}

variable "ssh_user" {
  description = "SSH user for provisioners"
  type        = string
  default     = null
}

variable "ssh_private_key" {
  description = "Path to SSH private key for provisioners"
  type        = string
  default     = null
}

variable "enable_autoscaling" {
  description = "Whether to enable auto scaling for the instance"
  type        = bool
  default     = false
}

variable "root_volume_encrypted" {
  description = "Whether to encrypt the root volume"
  type        = bool
  default     = true
}
