resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id

  vpc_security_group_ids = [var.vpc_security_group_ids]

  tags = {
    Name        = "${var.env}-instance"
    Environment = var.env
  }
}
