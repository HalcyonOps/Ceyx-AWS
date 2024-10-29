# modules/storage/s3/submodules/versioning/variables.tf

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
