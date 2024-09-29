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

#BucketACL
# allows anyone to read the objects inside of our bucket 
resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.next-js-bucket-99.id
  acl = "public-read"

  depends_on = [ 
    aws_s3_bucket_ownership_controls.bucket-ownership-control.id,
    aws_s3_bucket_public_access_block.bucket-public-access.id
    ]

}

# Create Bucket Policy 
# allows public access to all objects inside the s3 bucket 

resource "aws_s3_bucket_policy" "my-bucket-policy" {
  bucket = aws_s3_bucket.next-js-bucket-99.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "my-bucket-policy",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::next-js-bucket-99",
      "Principal": "*"
    }
  ]
}
POLICY
}