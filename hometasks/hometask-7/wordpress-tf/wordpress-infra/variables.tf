variable "env" {
  type    = string
  default = "dev"
}

variable "db_name" {
  type    = string
  default = "wordpress_db"
}

variable "db_username" {
  type    = string
  default = "wpuser"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "Sun123456"
}
