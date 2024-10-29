# modules/storage/s3/submodules/encryption/main.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string
}

variable "kms_key_arn" {
  type = string
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enabled ? 1 : 0
  bucket = var.bucket_id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_arn != null ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_key_arn
    }
  }
}
