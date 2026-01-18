locals {
  name_prefix = "${var.env}-hw6"

  common_tags = merge(
    var.tags,
    {
      Env = var.env
    }
  )
}
 