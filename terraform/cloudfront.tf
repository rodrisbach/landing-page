resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = aws_s3_bucket.main.website_endpoint
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.id
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for S3 Bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "S3Origin"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "My CloudFront Distribution"
    Environment = "Dev"
  }
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "Origin access identity for S3 bucket"
}

