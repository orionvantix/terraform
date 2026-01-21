variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_security_group_ids" {
  type = string
}

variable "subnet_id" {
  type = string
}