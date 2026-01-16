resource "aws_lb" "this" {
  name               = "${local.name_prefix}-hw5-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [aws_security_group.alb.id]
  subnets         = data.terraform_remote_state.network.outputs.public_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-hw5-alb"
      Tier = "alb"
    }
  )
}

resource "aws_lb_target_group" "this" {
  name     = "${local.name_prefix}-hw5-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    matcher             = "200-399"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-hw5-tg"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
