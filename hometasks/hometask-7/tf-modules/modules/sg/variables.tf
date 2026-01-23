variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "http_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ssh_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "mysql_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
