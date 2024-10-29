# modules/compute/ec2/variables.tf

# Core Configuration
variable "create" {
  description = "Whether to create an EC2 instance"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# Instance Configuration
variable "ami_id" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = "standard"
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  type        = string
  default     = null
}

# Network Configuration
variable "vpc_id" {
  description = "VPC ID where the instance will be created"
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

# Security Configuration
variable "create_security_group" {
  description = "Whether to create a security group"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "security_group_rules" {
  description = "Security group rules to add to the security group"
  type = map(list(object({
    description = optional(string)
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string))
    self        = optional(bool)
  })))
  default = {}
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = null
}

# IAM Configuration
variable "instance_profile_arn" {
  description = "IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = null
}

# Storage Configuration
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
  description = "KMS key ID for root volume encryption"
  type        = string
  default     = null
}

# Monitoring and Management
variable "enable_cloudwatch_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = true
}

variable "enable_ebs_optimization" {
  description = "Enable EBS optimization"
  type        = bool
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

# Auto Scaling Configuration
variable "enable_autoscaling" {
  description = "Whether to create Auto Scaling resources"
  type        = bool
  default     = false
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

# Provisioning Configuration
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

variable "enable_provisioners" {
  description = "Enable provisioners for the instance"
  type        = bool
  default     = false
}

variable "provisioner_commands" {
  description = "List of commands to run as provisioner"
  type        = list(string)
  default     = []
}

variable "ssh_user" {
  description = "SSH user for provisioner connection"
  type        = string
  default     = null
}

variable "ssh_private_key" {
  description = "Path to SSH private key for provisioner connection"
  type        = string
  default     = null
}

# Tagging
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

# Networking Configuration
variable "allocate_elastic_ip" {
  description = "Whether to allocate an Elastic IP for the instance"
  type        = bool
  default     = false
}

# Instance Configuration
variable "use_spot_instances" {
  description = "Whether to use Spot instances instead of On-Demand"
  type        = bool
  default     = false
}

variable "spot_price" {
  description = "Maximum price to request on the spot market. Defaults to on-demand price if empty"
  type        = string
  default     = null
  validation {
    condition     = var.spot_price == null || can(regex("^\\d+\\.\\d+$", var.spot_price))
    error_message = "Spot price must be a valid decimal number or null."
  }
}

# Storage Configuration
variable "additional_ebs_volumes" {
  description = "Additional EBS volumes to attach to the instance"
  type = list(object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    iops                  = optional(number)
    throughput            = optional(number)
    kms_key_id            = optional(string)
    delete_on_termination = bool
  }))
  default = []
}

# Instance Type Configuration
variable "create_spot_instance" {
  description = "Whether to create a spot instance instead of an on-demand instance"
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "Whether to enable EBS optimization for the instance"
  type        = bool
  default     = false
}

# Security Configuration
variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
  validation {
    condition     = can([for sg in var.vpc_security_group_ids : regex("^sg-[a-f0-9]{8,17}$", sg)])
    error_message = "Security group IDs must be valid (sg-xxxxxxxx or sg-xxxxxxxxxxxxxxxxx)."
  }
}
