locals {
  tags = merge(
    {
      Name        = var.name
      Module      = "ceyx/compute/ec2/security_group"
      Environment = var.environment
      Managed_By  = "terraform"
      Created_At  = timestamp()
    },
    var.tags
  )
}
