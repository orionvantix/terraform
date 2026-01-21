module "sg" {
  # arguments / to call module
  source = "../../modules/sg"   # where the module is, we can source modules locally and remotely
  # to specify module version
#   version = "value
  # to pass values to variables
  name = "dev-sg"
  description = "This is an a Dev security group"
}

module "ec2" {
  source = "../../modules/ec2"
# variables
  env = "dev"
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ module.sg.vpc_security_group_ids ]
    subnet_id = "subnet-0e71e22611472d913" 

  }

  # How to reference to Child Module
  # When a child module references to another child module, you wll need to use outputs
  # Similar to data.terraform_remote_state.network.outputs.private_subnets.ids

  # Syntax: module.sg.output_name
  # Example: module.sg.security_group.id

#  Calling a child module from a Terraform Resitry
# module "s3-bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"
#   version = "5.10.0"

#   bucket = "terraform-hw-3-bucket"
# }

# Calling a child module from Github Repository
module "web-sg" {
  source = "git::https://github.com/orionvantix/terraform.git//modules/sg?ref=main"

  name = "web-sg"
  description = "This is a web security group"
}