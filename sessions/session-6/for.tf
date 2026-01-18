resource "aws_sqs_queue" "main" {
  for_each = toset(var.names) // map and set of string (tuple)
  name     = each.key
}

variable "names" {
  type        = list(string)
  description = "This variable is sqs queue names"
  default     = ["queue-1", "queue-2", "queue-3"]
}

resource "aws_sqs_queue" "network" {
  for_each = toset(local.names)
  name     = each.key
}

# for = transform values

locals {
  names = [for a in range(1, 3) : "network-queue-${a}"]
}

resource "aws_security_group" "main" {
  name        = "aws-session-sg"
  description = "This is a security group for ec2 instance"
}
resource "aws_security_group_rule" "main" {
  for_each          = local.service # map of set of string
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [each.value.cidr_blocks]
  security_group_id = aws_security_group.main.id
}

variable "services" { # Global variable, List of maps
  default = [
    { name = "ssh", port = 22, cidr_blocks = "10.0.0.0/16" },
    { name = "web", port = 80, cidr_blocks = "0.0.0.0/0" }
  ]
}

locals {
  service = {
    for svc in var.services : svc.name => { port = svc.port, cidr_blocks = svc.cidr_blocks }
  }
}
