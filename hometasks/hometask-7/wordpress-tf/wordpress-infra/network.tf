# VPC
resource "aws_vpc" "wp" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "wp-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "wp" {
  vpc_id = aws_vpc.wp.id

  tags = {
    Name = "wp-igw"
  }
}

# Public subnet for EC2 (WordPress)
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.wp.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "wp-public-a"
  }
}

# Private subnets for RDS
resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "wp-db-a"
  }
}
resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "wp-db-b"
  }
}

# Route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.wp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp.id
  }

  tags = {
    Name = "wp-public-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}