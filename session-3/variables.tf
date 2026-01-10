variable "instance_type" {
  description = "aws ec2 instance type"
  type = string // data constraint or type
  default = "t3.micro"
}

variable "tags" {
    description = "common tags"
    type = map(string)
    default = {
        "Name"       = "aws-session-instance"
        "Environment" = "dev"
}
}

