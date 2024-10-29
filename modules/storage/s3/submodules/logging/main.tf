# modules/storage/s3/submodules/logging/main.tf

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

resource "aws_s3_bucket_logging" "this" {
  count  = var.enabled ? 1 : 0
  bucket = var.bucket_id

  target_bucket = var.target_bucket
  target_prefix = var.target_prefix
}
