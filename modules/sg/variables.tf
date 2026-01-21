variable "name" {
  type = string
  description = "Name of security group"
  default = "aws-session-sg"
}

variable "description" {
  type = string
  description = "Security group description"
  default = "This is an aws-session-sg"
}
