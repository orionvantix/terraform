# Create a VPC
resource "aws_vpc" "mainvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "aws-hw-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "aws-hw-igw"
  }
}

# Public and Private Subnets
# Public Subnets (3 AZs)
resource "aws_subnet" "public" {
  count = length(var.cidr_blocks_public)

  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.cidr_blocks_public[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "aws-hw-public-subnet-${count.index + 1}"
    Tier = "Public"
  }
}

# Private Subnets (3 AZs)
resource "aws_subnet" "private" {
  count = length(var.cidr_blocks_private)

  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.cidr_blocks_private[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "aws-hw-private-subnet-${count.index + 1}"
    Tier = "Private"
  }
}
