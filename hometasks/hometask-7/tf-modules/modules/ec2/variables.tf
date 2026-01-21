variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for Wordpress EC2 instance"
  default     = "ami-07ff62358b87c7116"
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