output "alb_dns" {
    value = aws_lb.mc_alb.dns_name
}
output "cf_domain" {
    value = module.cdn.cloudfront_distribution_domain_name
}