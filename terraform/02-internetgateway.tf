resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.main2.id

  tags = {
    Name = "igw2"
  }
}
