variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for Wordpress EC2 instance"
  default     = "ami-0c02fb55956c7d316"
}


variable "instance_type" {
  type        = string
  description = "Instance type for Wordpress EC2"
  default     = "t3.micro"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the instance"
}

variable "subnet_id" {
  type = string
  description = "Subnet Id where the instance will be created"
}