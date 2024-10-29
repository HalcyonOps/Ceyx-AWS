# modules/storage/s3/main.tf

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  acl           = var.acl
  force_destroy = var.force_destroy

  tags = merge(
    {
      "Module" = "terraform-aws-s3-advanced"
    },
    var.tags
  )

  # Block public access by default
  public_access_block {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

# Conditional inclusion of submodules

# Encryption
module "encryption" {
  source      = "./modules/encryption"
  enabled     = var.enable_encryption
  bucket_id   = aws_s3_bucket.this.id
  kms_key_arn = var.kms_key_arn
}

# Versioning
module "versioning" {
  source    = "./modules/versioning"
  enabled   = var.enable_versioning
  bucket_id = aws_s3_bucket.this.id
}

# Logging
module "logging" {
  source        = "./modules/logging"
  enabled       = var.enable_logging
  bucket_id     = aws_s3_bucket.this.id
  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}

# Lifecycle Rules
module "lifecycle" {
  source          = "./modules/lifecycle"
  enabled         = var.enable_lifecycle_rules
  bucket_id       = aws_s3_bucket.this.id
  lifecycle_rules = var.lifecycle_rules
}
