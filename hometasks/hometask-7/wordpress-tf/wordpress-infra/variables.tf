variable "env" {
  type    = string
  default = "dev"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type    = string
  default = "wordpress"
}

variable "user_data" {
  type        = string
  description = "EC2 userdata script content"
}
