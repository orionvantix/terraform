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
resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-2a"

    tags = {
        Name = "aws-hw-public-subnet-1"
        Tier = "Public"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2b"
    tags = {
        Name = "aws-hw-public-subnet-2"
        Tier = "Public"
    }
}

resource "aws_subnet" "public_3" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-2c"
    tags = {
        Name = "aws-hw-public-subnet-3"
        Tier = "Public"
    }
}   

# Private Subnets (3 AZs)
resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "us-east-2a"
    tags = {
        Name = "aws-hw-private-subnet-1"
        Tier = "Private"
    }
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "us-east-2b"
    tags = {
        Name = "aws-hw-private-subnet-2"
        Tier = "Private"
    }
}

resource "aws_subnet" "private_3" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.12.0/24"
    availability_zone = "us-east-2c"
    tags = {
        Name = "aws-hw-private-subnet-3"
        Tier = "Private"
    }
}   
