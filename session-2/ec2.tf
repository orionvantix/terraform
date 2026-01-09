resource "aws_instance" "first_ec2" {
  ami           = "ami-06f1fc9ae5ae7f31e"
  instance_type = "t3.micro"
  tags = {
    Name        = "first"
    Environment = "dev"
  }
}

# - resource = block, create and manage resources
# - aws_instance = first_label, indicate the resource 
#                that you want to create and manage, defined by Terraform
# - first_ec2 = second_label, logical id or logical 
#              name of the resource, defined by me (Must by unique within working directory)
# - argument = key value pair,configuration of the resource, key is defined by Terraform and value is given by us
# - Data types:
#            - "" = string
    # - {} = map


