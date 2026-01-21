variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for Wordpress EC2 instance"
  default     = "ami-02dc6e3e481e2bbc5"
}


variable "instance_type" {
  type        = string
  description = "Instance type for Wordpress EC2"
  default     = "t3.micro"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group ID for the instance"
}

variable "subnet_id" {
  type = string
  description = "Subnet Id where the instance will be created"
}