resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat2.id
  }

  tags = {
    Name = "private2"
  }
}

resource "aws_route_table" "public2" {
  vpc_id = aws_vpc.main2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
  }

  tags = {
    Name = "public2"
  }
}

resource "aws_route_table_association" "route_table_association_private2_eucentral1_a" {
  route_table_id = aws_route_table.private2.id
  subnet_id = aws_subnet.private2-eu-central-1a.id
}

resource "aws_route_table_association" "route_table_association_private2_eucentral1_b" {
  route_table_id = aws_route_table.private2.id
  subnet_id = aws_subnet.private2-eu-central-1b.id
}

resource "aws_route_table_association" "route_table_association_public2_eucentral1_a" {
  route_table_id = aws_route_table.public2.id
  subnet_id = aws_subnet.public2-eu-central-1a.id
}

resource "aws_route_table_association" "route_table_association_public2_eucentral1_b" {
  route_table_id = aws_route_table.public2.id
  subnet_id = aws_subnet.public2-eu-central-1b.id
}
