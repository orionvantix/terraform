output "instance_id" {
  value = aws_instance.main.id
  description = "ID of the EC2 instance"
}

output "public_ip" {
  value = aws_instance.main.public.ip
  description = "Public IP of the EC2 instance"
}