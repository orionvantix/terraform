variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs for RDS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for DB subnet group"
}

variable "identifier" {
  type        = string
  description = "RDS instance identifier"
}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in GB"
  default     = 20
}

variable "username" {
  type        = string
  description = "Master username"
}

variable "password" {
  type        = string
  description = "Master password"
}

variable "db_name" {
  type        = string
  description = "Initial DB name"
}

variable "port" {
  type        = number
  description = "DB port"
  default     = 3306
}
