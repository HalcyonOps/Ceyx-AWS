# modules/storage/s3/submodules/lifecycle/variables.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string

  validation {
    condition     = length(var.bucket_id) > 0
    error_message = "Bucket ID must not be empty."
  }
}

variable "lifecycle_rules" {
  type = list(any)

  validation {
    condition     = var.enabled == false || (var.enabled == true && length(var.lifecycle_rules) > 0)
    error_message = "When lifecycle rules are enabled, 'lifecycle_rules' must contain at least one rule."
  }
}
