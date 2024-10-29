# modules/storage/s3/submodules/logging/variables.tf

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

variable "target_bucket" {
  type = string

  validation {
    condition     = var.enabled == false || (var.enabled == true && length(var.target_bucket) > 0)
    error_message = "When logging is enabled, 'target_bucket' must be specified."
  }
}

variable "target_prefix" {
  type = string
  default = ""

  validation {
    condition     = var.target_prefix != null
    error_message = "'target_prefix' cannot be null."
  }
}
