resource "aws_autoscaling_group" "web" {
  name                      = "${local.name_prefix}-hw5-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  health_check_type         = "EC2"
  health_check_grace_period = 60

  vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnet_ids

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.this.arn]

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-hw5-web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
