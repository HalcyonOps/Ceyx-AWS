# modules/storage/s3/submodules/lifecycle/main.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string
}

variable "lifecycle_rules" {
  type = list(any)
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enabled ? 1 : 0
  bucket = var.bucket_id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"
      prefix = rule.value.prefix

      dynamic "transition" {
        for_each = rule.value.transitions
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      expiration {
        days = rule.value.expiration.days
      }
    }
  }
}
