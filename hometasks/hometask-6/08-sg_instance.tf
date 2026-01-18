resource "aws_security_group" "web" {
  name        = "${local.name_prefix}-web-sg"
  description = "SG for web instances behind ALB"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = local.web_tags
}

# Allow HTTP only from ALB SG
resource "aws_security_group_rule" "web_ingress_http_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web.id
  source_security_group_id = aws_security_group.alb.id
}

# Egress all
resource "aws_security_group_rule" "web_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}
