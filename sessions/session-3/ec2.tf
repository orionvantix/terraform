resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = var.tags
}



# second label must be unique
# as long as these are different resources (first_label), 
#    you can use same name
# Example:
# aws_instance.main
# aws_security_group

# Reference to Resource = Reference to an attribute of that Resource that already exists
# Syntax: First_label.Second_label.Attribute
# aws_security_group.main.id

# vpc_security_group_ids = [aws_security_group.main.id]

# Reference to Input Variable
# Syntax: var.variable_name
# Example: var.instance_type

# Resource Type/Block is to create and manage resources

# Data Source Type/Block is to fetch the data from existing resources

# Reference to Data Source?
#  Syntax: data.first_label.second_label.attribute
# Example: data.aws_ami.amazon_linux_2023.id