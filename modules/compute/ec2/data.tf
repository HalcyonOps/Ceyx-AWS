data "aws_ec2_instance_type" "selected" {
  instance_type = var.instance_type
}

data "aws_ami" "this" {
  count = var.ami_id == null ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
