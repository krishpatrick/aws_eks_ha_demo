resource "aws_subnet" "private2-eu-central-1a" {
  vpc_id            = aws_vpc.main2.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "eu-central-1a"

  tags = {
    "Name"                                      = "private2-eu-central-1a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private2-eu-central-1b" {
  vpc_id            = aws_vpc.main2.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "eu-central-1b"

  tags = {
    "Name"                                      = "private2-eu-central-1b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public2-eu-central-1a" {
  vpc_id                  = aws_vpc.main2.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public2-eu-central-1a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public2-eu-central-1b" {
  vpc_id                  = aws_vpc.main2.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public2-eu-central-1b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
