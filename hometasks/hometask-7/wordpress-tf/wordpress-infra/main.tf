# data to get default vpc
data "aws_vpc" "default" {
  default = true
}

module "sg" {
  # call module
  source = "../../tf-modules/modules/sg"
  name = "wordpress-sg"
  description = "This is Wordpress security group"
  vpc_id = data.aws_vpc.default.id
}

module "ec2" {
  source = "../../tf-modules/modules/ec2"
  # variables
  env = "wordpress"
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ module.sg.vpc_security_group_ids ]
  subnet_id = "subnet-0e71e22611472d913"
}

module "rds" {
  source = "../../tf-modules/modules/rds"

  identifier = "wordpress-db"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  username = "wpuser"
  password = "sun123"
  db_name = "wordpress"
  vpc_security_group = module.sg.vpc_security_group.ids
}

module "s3-bucket" {
  source = "https://github.com/orionvantix/terraform//hometasks/hometask-3/modules/s3"
#   version = "value"

  bucket = "terraform-hw-3-bucket"
}