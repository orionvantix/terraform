data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b"]
  }
}



module "sg" {
  source      = "git::ssh://git@github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/sg?ref=main"
  name        = "wordpress-sg"
  description = "This is wordpress security group"
  vpc_id      = data.aws_vpc.default.id
}

module "ec2" {
  source = "git::ssh://git@github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/ec2?ref=main"
  env                   = "wordpress"
  ami_id                = "ami-02dc6e3e481e2bbc5"
  instance_type         = "t3.micro"
  vpc_security_group_ids = module.sg.vpc_security_group_ids
  subnet_id             = data.aws_subnets.default.ids[0]
}

module "rds" {
  source = "git::ssh://git@github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/rds?ref=main"

  identifier        = "wordpress-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = "wpuser"
  password          = "sun123"
  db_name           = "wordpress"

  vpc_security_group_id = module.sg.vpc_security_group_ids
  subnet_ids            = data.aws_subnets.default.ids
}

