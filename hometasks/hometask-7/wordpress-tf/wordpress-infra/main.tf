data "aws_vpc" "default" {
  default = true
}
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
  cidr_block              = "172.31.101.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "wordpress-db-a"
  }
}
resource "aws_subnet" "db_b" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.102.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "wordpress-db-b"
  }
}
module "sg" {
  source      = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/sg?ref=main"
  name        = "wordpress-sg"
  description = "This is wordpress security group"
  vpc_id      = data.aws_vpc.default.id
}
module "ec2" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/ec2?ref=main"

  env                    = var.env
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = module.sg.ids
  user_data              = file("${path.module}/wp_userdata.sh")
}
module "rds" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/rds?ref=main"

  identifier        = "wordpress-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = "wpuser"
  password          = "Sun123456"
  db_name           = "wordpress"

  vpc_security_group_ids = module.sg.ids
  subnet_ids             = [aws_subnet.db_a.id, aws_subnet.db_b.id]
}


