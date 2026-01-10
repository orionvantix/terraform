# Security Groups
# Public SG
resource "aws_security_group" "public" {
    name = "aws-hw-sg"
    description = "Security group for AWS hometask-instances"
    vpc_id = aws_vpc.mainvpc.id
    
   ingress {
    description = "SSH"
    protocol  = "tcp"
    from_port = 22
    to_port   = 22 
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
        Name = "aws-hw-sg"
    }
}

# Private SG
resource "aws_security_group" "private" {
   name        = "aws-hw-priv-sg"
   description = "Private security group for AWS hometask-instances"
   vpc_id      = aws_vpc.mainvpc.id

#    Allow all traffic within the SG
   ingress {
       protocol    = "-1"
       self        = true
       from_port   = 0
       to_port     = 0    
   }

    egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
}
   tags = {
       Name = "aws-hw-priv-sg"
    }

  }
