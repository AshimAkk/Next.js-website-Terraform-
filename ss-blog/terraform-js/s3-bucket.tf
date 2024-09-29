#Create S3 bucket to hold website static content

resource "aws_s3_bucket" "next-js-bucket-99" {
  bucket = "next-js-bucket-99"


  tags = {
    Name = "next-js-bucket-99"
  }
}

#Ownership Control 

resource "aws_s3_bucket_ownership_controls" "bucket-ownership-control" {
  bucket = aws_s3_bucket.next-js-bucket-99.id

  rule {
    object_ownership = "BucketOwnerPrefferred"
  }
}


#Allowing Public access to Our bucket 
resource "aws_s3_bucket_public_access_block" "bucket-public-access" {
  bucket = aws_s3_bucket.next-js-bucket-99.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}