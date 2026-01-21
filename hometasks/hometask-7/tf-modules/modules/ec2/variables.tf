variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "ami" {
  type = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type = string
  description = "EC2 instance type"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the instance"
}

variable "subnet_id" {
  type = string
  description = "Subnet Id where the instance will be created"
}