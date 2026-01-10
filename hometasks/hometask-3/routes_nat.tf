# EIP for NAT Gateway
resource "aws_eip" "nat" {

}

# NAT in a public subnet
resource "aws_nat_gateway" "default" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public_1.id

    tags = {
        Name = "aws-hw-nat-gw"
    }

    depends_on = [ aws_internet_gateway.igw ]
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
resource "aws_route_table_association" "public_1" {
    subnet_id      = aws_subnet.public_1.id
    route_table_id = aws_default_route_table.public.id
}
resource "aws_route_table_association" "public_2" {
    subnet_id      = aws_subnet.public_2.id
    route_table_id = aws_default_route_table.public.id
}
resource "aws_route_table_association" "public_3" {
    subnet_id      =aws_subnet.public_3.id
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
resource "aws_route_table_association" "private_1" {
    subnet_id      = aws_subnet.private_1.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_2" {
    subnet_id      = aws_subnet.private_2.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_3" {
    subnet_id      =aws_subnet.private_3.id
    route_table_id = aws_route_table.private.id
}  