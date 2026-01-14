variable "cidr_blocks_public" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "cidr_blocks_private" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ports" {
  description = "List of ports to allow"
  type        = list(number)
  default     = [22, 80, 443]

}

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
