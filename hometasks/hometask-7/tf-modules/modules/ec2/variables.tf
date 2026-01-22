variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "ami" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the instance will be created"
}

variable "user_data" {
  type        = string
  description = "User data script content"
}
