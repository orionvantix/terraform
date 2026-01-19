locals {

  user_data_web = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Hello World from ${local.name_prefix}-web</h1>" > /var/www/html/index.html
  EOF
}

resource "aws_launch_template" "web" {
  name_prefix   = "${local.name_prefix}-hw6-web-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  # explicit private-only config
  network_interfaces {
    security_groups             = [aws_security_group.web.id]
    associate_public_ip_address = false
  }

  user_data = base64encode(local.user_data_web)

  tag_specifications {
    resource_type = "instance"

    tags = local.web_tags
  }
}