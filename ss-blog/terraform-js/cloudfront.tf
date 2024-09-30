# Origin access identity

resource "aws_cloudfront_origin_access_identity" "origin-access-identity" {
    comment = "OAI for next.js website"
  
}

# Create s3 Cloudfront distribution

resource "aws_cloudfront_distribution" "nextjs-website-distribution" {
  origin {
    domain_name = aws_s3_bucket.next-js-bucket-99.bucket_regional_domain_name
    origin_id   = "next-js-bucket-99"

# specifies the OAI CloudFront uses to access the s3 bucket
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin-access-identity.cloudfront_access_identity_path
    }
  }


  enabled             = true
  is_ipv6_enabled = true 
  comment = "Nextjs website"   
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.next-js-bucket-99.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

}