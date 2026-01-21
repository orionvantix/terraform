data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "sg" {
  source      = "https://github.com/orionvantix/terraform/tree/main/hometasks/hometask-7/tf-modules/modules/sg"
  name        = "wordpress-sg"
  description = "This is wordpress security group"
  vpc_id      = data.aws_vpc.default.id
}

module "ec2" {
  source                = "https://github.com/orionvantix/terraform/tree/main/hometasks/hometask-7/tf-modules/modules/ec2"
  env                   = "wordpress"
  ami_id                = "ami-07ff623588bc7f116"
  instance_type         = "t3.micro"
  vpc_security_group_ids = module.sg.vpc_security_group_ids
  subnet_id             = data.aws_subnets.default.ids[0]
}

module "rds" {
  source             = "https://github.com/orionvantix/terraform/tree/main/hometasks/hometask-7/tf-modules/modules/rds"
  identifier         = "wordpress-db"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  username           = "wpuser"
  password           = "sun123"
  db_name            = "wordpress"
  vpc_security_group_id = module.sg.vpc_security_group_ids[0]
  subnet_ids         = data.aws_subnets.default.ids
}
