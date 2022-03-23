
resource "aws_s3_bucket" "b" {
  bucket = "mc-cf-s3-bucket"

  tags = {
    Name = "MC CF S3 Bucket"
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases             = ["blog.meta-carbon.click"]
  comment             = "MC CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = true
  http_version        = "http2"

  logging_config = {
    bucket          = aws_s3_bucket.b.bucket_domain_name
    include_cookies = false
    prefix          = "ghost"
  }

  origin = [
    {
      domain_name = aws_lb.mc_alb.dns_name
      origin_id   = var.origin_id
      origin_path = ""
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }

    }
  ]

  default_cache_behavior = {
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = false
    query_string    = true  
    forwarded_values = [
      {
        cookies = [
          {
            forward           = "all",
            whitelisted_names = []
          }
        ]
        headers = ["x-forwarded-host"]
        query_string            = true
        query_string_cache_keys = []
      }
    ]
  }

  viewer_certificate = {
    acm_certificate_arn      = var.cert
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1_2016"
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.1_2016"
  }
}
