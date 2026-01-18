variable "tags" {
  type        = map(string)
  description = "common tags"
  default = {
    Project    = "terraform-hw-3"
    Managed_by = "Terraform"
  }
}

variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}