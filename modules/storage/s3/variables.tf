# modules/storage/s3/variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string

  validation {
    condition     = length(var.bucket_name) > 0 && length(var.bucket_name) <= 63 && can(regex("^[a-z0-9.-]+$", var.bucket_name))
    error_message = "Bucket name must be 1-63 characters long, consisting only of lowercase letters, numbers, dots, and hyphens."
  }
}

variable "acl" {
  description = "The canned ACL to apply."
  type        = string
  default     = "private"

  validation {
    condition = contains([
      "private",
      "public-read",
      "public-read-write",
      "authenticated-read",
      "log-delivery-write",
      "aws-exec-read",
      "bucket-owner-read",
      "bucket-owner-full-control"
    ], var.acl)
    error_message = "Invalid ACL. Must be one of the predefined canned ACLs."
  }
}

variable "force_destroy" {
  description = "Force destroy the bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the bucket."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for key, value in var.tags : length(key) > 0 && length(value) > 0])
    error_message = "Tag keys and values must not be empty."
  }
}

# Encryption Variables
variable "enable_encryption" {
  description = "Enable server-side encryption for the bucket."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption (if using SSE-KMS)."
  type        = string
  default     = null

  validation {
    condition     = var.kms_key_arn == null || can(regex("^arn:aws(-[a-z]+)?:kms:[a-z0-9-]+:\\d{12}:key/[a-f0-9-]{36}$", var.kms_key_arn))
    error_message = "Invalid KMS Key ARN."
  }
}

# Versioning Variables
variable "enable_versioning" {
  description = "Enable versioning for the bucket."
  type        = bool
  default     = false
}

# Logging Variables
variable "enable_logging" {
  description = "Enable access logging for the bucket."
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "The S3 bucket to store access logs."
  type        = string
  default     = null

  validation {
    condition     = var.enable_logging == false || (var.enable_logging == true && length(var.logging_target_bucket) > 0)
    error_message = "When logging is enabled, 'logging_target_bucket' must be specified."
  }
}

variable "logging_target_prefix" {
  description = "A prefix for access log object keys."
  type        = string
  default     = null
}

# Lifecycle Variables
variable "enable_lifecycle_rules" {
  description = "Enable lifecycle rules for the bucket."
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "A list of lifecycle rule configurations."
  type = list(object({
    id      = string
    prefix  = string
    enabled = bool
    transitions = list(object({
      days          = number
      storage_class = string
    }))
    expiration = object({
      days = number
    })
  }))
  default = []

  validation {
    condition = var.enable_lifecycle_rules == false || (var.enable_lifecycle_rules == true && length(var.lifecycle_rules) > 0)
    error_message = "When lifecycle rules are enabled, 'lifecycle_rules' must contain at least one rule."
  }
}
