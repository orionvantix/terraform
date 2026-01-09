resource "aws_instance" "example" {
  ami           = "ami-06f1fc9ae5ae7f31e"
  instance_type = "t3.micro"

user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable --now httpd
echo "<html><body><h1>Session-2 homework is complete! </h1></body></html>" > /var/www/html/index.html
EOF

  tags = {
    Name = "my-terraform-webserver"
  }
}