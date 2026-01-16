# EIP for NAT Gateway
resource "aws_eip" "nat" {

}

# NAT in a public subnet
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "aws-hw-nat-gw"
  }
}

# Route Tables
#  -------------------------- Public Routing --------------------------
resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.mainvpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "aws-hw-public-rt"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_default_route_table.public.id
}

# -------------------------- Private Routing --------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.default.id
  }
  tags = {
    Name = "aws-hw-private-rt"
  }
}

# Associate Private Subnets with Route Table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
