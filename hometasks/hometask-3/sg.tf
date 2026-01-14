# Security Groups
resource "aws_security_group" "main" {
  name        = "aws-hw-sg"
  description = "Security group for AWS hometask-instances"
  tags = merge(
    var.tags,
    {
      Name = "${var.env}-aws-hw-sg"
    }
  )
}

resource "aws_security_group_rule" "main" {
  count             = length(var.ports)
  type              = "ingress"
  from_port         = var.ports[count.index]
  to_port           = var.ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks_public[count.index]]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "main_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}