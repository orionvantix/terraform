variable "vpc_security_group_id" {
  type        = string
  description = "Security group ID for RDS"
}

variable "identifier" {
  type = string
  description = "RDS instance identifier"
}

variable "instance_class" {
  type = string
  description = "RDS instance class"
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type = number
  description = "Allocated storage in GB"
  default = 20
}

variable "username" {
  type = string
  description = "Master username for the DB"
}

variable "password" {
  type = string
  description = "Master password for the DB"
}

variable "db_name" {
  type = string
  description = "Initial database name"
}

variable "port" {
  type = number
  description = "DB port"
  default = 3306
}