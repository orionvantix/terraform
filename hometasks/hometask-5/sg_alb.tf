resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-hw5-alb-sg"
  description = "ALB security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-hw5-alb-sg"
      Tier = "alb"
    }
  )
}

# Ingress: 80, 443
resource "aws_security_group_rule" "alb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "alb_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
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
