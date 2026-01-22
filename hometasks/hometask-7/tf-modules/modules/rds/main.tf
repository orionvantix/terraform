resource "aws_db_subnet_group" "main" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier        = var.identifier
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  username          = var.username
  password          = var.password
  db_name           = var.db_name
  port              = var.port


  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.main.name

  skip_final_snapshot = true
}

