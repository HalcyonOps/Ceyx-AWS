# modules/compute/ec2/submodules/elastic_ip/main.tf

resource "aws_eip" "this" {
  count = var.allocate_elastic_ip ? 1 : 0

  domain = "vpc"

  tags = var.tags
}
