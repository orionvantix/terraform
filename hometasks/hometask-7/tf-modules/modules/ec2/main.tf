resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = var.user_data

  tags = {
    Name        = "${var.env}-instance"
    Environment = var.env
  }
}
