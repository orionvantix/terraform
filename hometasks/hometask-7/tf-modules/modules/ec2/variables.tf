variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

variable "instance_type" {
  type        = string
  description = "Instance type for Wordpress EC2"
  default     = "t3.micro"
}

variable "vpc_security_group_ids" {
  type        = string
  description = "Security group ID for the instance"
}

variable "subnet_id" {
  type = string
  description = "Subnet Id where the instance will be created"
}