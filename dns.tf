resource "aws_route53_record" "mc-alb_dns" {
  zone_id = "Z00088362UJA4TKOAK4W5"
  name    = "blog"
  type    = "CNAME"
  ttl     = "5"

  records        = [module.cdn.cloudfront_distribution_domain_name]
}
