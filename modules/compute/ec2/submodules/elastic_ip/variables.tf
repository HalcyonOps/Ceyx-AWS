# modules/compute/ec2/submodules/elastic_ip/variables.tf

variable "allocate_elastic_ip" {
  description = "Flag to allocate an Elastic IP"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the Elastic IP"
  type        = map(string)
  default     = {}
}