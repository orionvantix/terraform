resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "ALB security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = local.alb_tags
}

# Ingress: 80, 443
# One resource, creates rules for ports 80, 443
resource "aws_security_group_rule" "alb_ingress" {
  for_each = {
    http  = 80
    https = 443
  }

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

# Egress: all
resource "aws_security_group_rule" "alb_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}
