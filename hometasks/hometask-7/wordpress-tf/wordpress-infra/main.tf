data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_subnet" "db_a" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "10.0.101.0/24"   # adjust if this conflicts
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "wordpress-db-a"
  }
}

resource "aws_subnet" "db_b" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "10.0.102.0/24"   # adjust if needed
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "wordpress-db-b"
  }
}

module "sg" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/sg?ref=main"

  name        = "wordpress-sg"
  description = "This is wordpress security group"
  vpc_id      = data.aws_vpc.default.id
}

module "ec2" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/ec2?ref=main"

  env                    = "wordpress"
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.sg.vpc_security_group_ids]
  subnet_id              = data.aws_subnets.default.ids[0]
}

module "rds" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/rds?ref=main"

  identifier        = "wordpress-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = "wpuser"
  password          = "sun123"
  db_name           = "wordpress"

  vpc_security_group_id = module.sg.vpc_security_group_ids
   subnet_ids = [
    aws_subnet.db_a.id,
    aws_subnet.db_b.id,
  ]
}


