resource "aws_route53_record" "root_alias" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "n8n-create.com"
  type    = "A"
  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}