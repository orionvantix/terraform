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
  }

  # How to reference to Child Module
  # When a child module references to another child module, you wll need to use outputs
  # Similar to data.terraform_remote_state.network.outputs.private_subnets.ids

  # Syntax: module.sg.output_name
  # Example: module.sg.security_group.id