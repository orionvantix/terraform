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
  default = []
}

variable "ssh_cidrs" {
  type    = list(string)
  default = []
}

variable "mysql_cidrs" {
  type    = list(string)
  default = []
}
