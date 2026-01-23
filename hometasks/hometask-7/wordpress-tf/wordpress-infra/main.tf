module "sg" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/sg?ref=main"

  name        = "wordpress-sg"
  description = "Security group for wordpress web + db"
  vpc_id      = aws_vpc.wp.id

  http_cidrs  = ["0.0.0.0/0"]
  ssh_cidrs   = ["0.0.0.0/0"]
  mysql_cidrs = ["10.0.0.0/16"]
}

module "ec2" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/ec2?ref=main"

  name = "wordpress-ec2"
  env  = var.env

  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_a.id
  vpc_security_group_ids = module.sg.ids

  user_data = templatefile("${path.module}/wp_userdata.sh.tpl", {
  db_name     = var.db_name
  db_user     = var.db_username  # <- change this key name
  db_password = var.db_password
  db_host     = module.rds.endpoint
})

  key_name            = "wp-key"
  associate_public_ip = true
}



module "rds" {
  source = "git::https://github.com/orionvantix/terraform.git//hometasks/hometask-7/tf-modules/modules/rds?ref=main"

  identifier        = "wordpress-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = var.db_username
  password          = var.db_password
  db_name           = var.db_name

  vpc_security_group_ids = module.sg.ids
  subnet_ids             = [aws_subnet.db_a.id, aws_subnet.db_b.id]
}


