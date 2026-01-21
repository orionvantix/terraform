resource "aws_instance" "main" {
  ami           = var.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  # wrap the single SG id into a list
  vpc_security_group_ids = [var.vpc_security_group_ids]

  tags = {
    Name        = "${var.env}-instance"
    Environment = var.env
  }
}
