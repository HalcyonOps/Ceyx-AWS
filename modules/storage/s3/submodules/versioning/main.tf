# modules/storage/s3/submodules/versioning/main.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = var.bucket_id

  versioning_configuration {
    status = var.enabled ? "Enabled" : "Suspended"
  }
}
