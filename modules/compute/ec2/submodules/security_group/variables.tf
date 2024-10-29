# modules/compute/ec2/submodules/security_group/variables.tf

variable "name" {
  description = "Name to be used on security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "create_security_group" {
  description = "Flag to create security group"
  type        = bool
  default     = false
}

variable "security_group_rules" {
  description = "Security group rules for the instance"
  type = object({
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  })
  default = {
    ingress = []
    egress  = []
  }
}

variable "environment" {
  description = "Environment for the security group"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
