locals {
  tags = merge(
    var.tags,
    {
      Name        = var.name
      Module      = "ceyx/compute/ec2"
      Environment = var.environment
      Managed_By  = "terraform"
    }
  )
}