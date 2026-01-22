output "ec2_public_ip" {
  description = "Public IP of Wordpress EC2"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
}
