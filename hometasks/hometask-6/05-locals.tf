locals {
  app_name = "hw6"
  env = var.env
  name_prefix = "${local.env}-${local.app_name}"

# base tags used everywhere
  common_tags = merge(
    var.tags,           # Project, Managed_by from variables.tf
    {
      Env = local.env
      App = local.app_name
    }
  )

# tags per "tier"
  alb_tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb"
      Tier = "alb"
    }
  )

  web_tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-web"
      Tier = "web"
    }
  )

  # for ASG we just reuse web_tags
  asg_tags = local.web_tags
}