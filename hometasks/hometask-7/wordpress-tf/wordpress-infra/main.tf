# data to get default vpc
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
  source      = "git@github.com:orionvantix/tf-modules.git//modules/sg"
  name        = "wordpress-sg"
  description = "This is Wordpress security group"
  vpc_id      = data.aws_vpc.default.id
}

module "ec2" {
  source = "git@github.com:orionvantix/tf-modules.git//modules/ec2"

  env                    = "wordpress"
  ami                    = "ami-07ff62358bb7c7116"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.sg.vpc_security_group_ids]
  subnet_id              = data.aws_subnets.default.ids[0]
}

module "rds" {
  source = "git@github.com:orionvantix/tf-modules.git//modules/rds"

  identifier            = "wordpress-db"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  username              = "wpuser"
  password              = "suni123"
  db_name               = "wordpress"
  vpc_security_group_id = module.sg.vpc_security_group_ids
}


# module "s3-bucket" {
#   source = "https://github.com/orionvantix/terraform//hometasks/hometask-3/modules/s3"
# #   version = "value"

#   bucket = "terraform-hw-3-bucket"
# }