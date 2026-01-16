locals {
  name_prefix = "${var.env}-hw5"

  common_tags = merge(
    var.tags,
    {
      Env = var.env
    }
  )
}
