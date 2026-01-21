variable "name" {
  type = string
  description = "Name of security group"
  default = "aws-hw-7-sg"
}

variable "description" {
  type = string
  description = "Security group description"
  default = "This is an aws-hw-7-sg"
}

variable "vpc_id" {
  type = string
  description = "VPC ID where the SG will be created"
}