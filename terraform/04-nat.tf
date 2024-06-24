resource "aws_eip" "nat2" {
  vpc = true

  tags = {
    Name = "nat2"
  }
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public2-eu-central-1a.id

  tags = {
    Name = "nat2"
  }

  depends_on = [aws_internet_gateway.igw2]
}

