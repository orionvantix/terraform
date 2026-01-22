output "endpoint" {
  value = aws_db_instance.main.endpoint
  description = "DNS address of the RDS instance"
}

output "port" {
  value = aws_db_instance.main.port
  description = "Port of the RDS instance"
}