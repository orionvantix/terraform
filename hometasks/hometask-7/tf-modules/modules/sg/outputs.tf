output "vpc_security_group_ids" {
  value = aws_security_group.main.id
  description = "Security group ID to be attached to EC2 and RDS"
}