variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "ami" {}
variable "instance_type" {}
variable "vpc_security_group_ids" {}