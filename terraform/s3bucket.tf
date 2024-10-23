provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_s3_bucket" "main" {
  bucket = "your-unique-bucket-name" # Change to your unique bucket name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name        = "My Website Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.main.arn}/*"
      },
    ]
  })
}

