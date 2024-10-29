# modules/storage/s3/variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "acl" {
  description = "The canned ACL to apply."
  type        = string
  default     = "private"
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
}
