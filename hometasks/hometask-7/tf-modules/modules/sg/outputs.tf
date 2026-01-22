output "id" {
  description = "Security group ID"
  value       = aws_security_group.main.id
}

output "ids" {
  description = "List of security group IDs"
  value       = [aws_security_group.main.id]
}
