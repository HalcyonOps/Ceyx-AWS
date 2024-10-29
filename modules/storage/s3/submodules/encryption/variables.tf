# modules/storage/s3/submodules/encryption/variables.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string
}

variable "kms_key_arn" {
  type = string
}
