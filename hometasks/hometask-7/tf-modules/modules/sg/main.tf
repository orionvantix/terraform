resource "aws_security_group" "main" {
  name = var.name
  description = var.description
  tags = {
    Name = var.name
  }
}

# HTTP for Wordpress
ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

# SSH (for management)
ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
}

# MySQL (RDS)
ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
}

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
}

tags = {
    Name = var.name
}