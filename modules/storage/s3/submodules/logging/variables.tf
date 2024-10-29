# modules/storage/s3/submodules/logging/variables.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string
}

variable "target_bucket" {
  type = string
}

variable "target_prefix" {
  type = string
}
