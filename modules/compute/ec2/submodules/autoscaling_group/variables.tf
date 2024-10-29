# modules/compute/ec2/submodules/autoscaling_group/variables.tf

variable "name" {
  description = "Name prefix for the Auto Scaling Group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "launch_template_id" {
  description = "ID of the launch template to use for the Auto Scaling Group"
  type        = string
}
