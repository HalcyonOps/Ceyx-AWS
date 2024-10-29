# modules/storage/s3/submodules/lifecycle/variables.tf

variable "enabled" {
  type = bool
}

variable "bucket_id" {
  type = string
}

variable "lifecycle_rules" {
  type = list(any)
}
