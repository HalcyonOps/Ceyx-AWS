# modules/storage/s3/submodules/encryption/variables.tf

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

variable "kms_key_arn" {
  type = string

  validation {
    condition = var.enabled == false || (var.enabled == true && (
      var.kms_key_arn == null || can(regex("^arn:aws(-[a-z]+)?:kms:[a-z0-9-]+:\\d{12}:key/[a-f0-9-]{36}$", var.kms_key_arn))
    ))
    error_message = "Invalid KMS Key ARN."
  }
}
