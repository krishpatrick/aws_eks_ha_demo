resource "aws_vpc" "main2" {
  cidr_block = "10.0.0.0/16"

  # Must be enabled for usage like for example EFS
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main2"
  }
}
