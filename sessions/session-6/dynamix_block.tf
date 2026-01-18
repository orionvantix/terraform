resource "aws_security_group" "dynamic" {
  name        = "dynamic-sg"
  description = "This is a security group for ec2 instance"

  dynamic ingress {
    for_each = var.inbound_rules # map, set of string
    iterator = ports
    
    content {
      from_port   = ports.value.port
      to_port     = ports.value.port
      protocol    = ports.value.protocol
      cidr_blocks = ports.value.cidr_block
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "inbound_rules" {
  description = "This is a variable for inbound rules"
  type = list(object({ # a list of objects where every item must follow the same schema
    port       = number
    protocol   = string
    cidr_block = list(string)
  }))

  default = [
    {
      port       = 80
      protocol   = "tcp"
      cidr_block = ["0.0.0.0/0"]
    },
    { port       = 443
      protocol   = "tcp"
      cidr_block = ["0.0.0.0/0"]
    },
    { port       = 22
      protocol   = "tcp"
      cidr_block = ["10.0.0.0/16"]
    }
  ]
}