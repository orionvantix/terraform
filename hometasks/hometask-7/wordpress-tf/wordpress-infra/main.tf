module "sg_web" {
  source      = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/sg?ref=main"

  name        = "wordpress-web-sg"
  description = "Security group for WordPress EC2"
  vpc_id      = aws_vpc.wp.id

  http_cidrs  = ["0.0.0.0/0"]
  ssh_cidrs   = ["0.0.0.0/0"]
  mysql_cidrs = []
}

module "sg_db" {
  source      = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/sg?ref=main"
  
  name        = "wordpress-db-sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.wp.id

  # no HTTP/SSH access from the internet
  http_cidrs = []
  ssh_cidrs  = []

  # allow MySQL only from inside VPC
  mysql_cidrs = [aws_vpc.wp.cidr_block]  # "10.0.0.0/16"
}


module "ec2" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/ec2?ref=main"

  name          = "wordpress-ec2"
  env           = var.env
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_a.id

  vpc_security_group_ids = module.sg_web.ids

  user_data = templatefile("${path.module}/wp_userdata.sh.tpl", {
    db_name     = var.db_name
    db_user     = var.db_username
    db_password = var.db_password
    db_host     = module.rds.endpoint
  })

  key_name            = "wp-key"
  associate_public_ip = true
}

module "rds" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/rds?ref=main"

  identifier       = "wordpress-db"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username = var.db_username
  password = var.db_password
  db_name  = var.db_name

  vpc_security_group_ids = module.sg_db.ids
  subnet_ids             = [aws_subnet.db_a.id, aws_subnet.db_b.id]
}


