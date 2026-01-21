resource "aws_sqs_queue" "main" {
  name = format("%s-sqs-queue", var.env)
}

variable "env" {
  type = string
  description = "Environment"
  default = "dev"
}