terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "terraform-bucket" {
    bucket = "tf-aws-project1-${random_id.rand_id.hex}" 
    force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.terraform-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.terraform-bucket.id
  policy = jsonencode(
    {
    Version= "2012-10-17",
    Statement= [
        {
            Sid= "PublicReadGetObject",
            Effect= "Allow",
            Principal= "*",
            Action= "s3:GetObject"
            Resource= "arn:aws:s3:::${aws_s3_bucket.terraform-bucket.id}/*"
        }
    ]
}
  )
}


resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.terraform-bucket.id

  index_document {
    suffix = "index.html"
  }
}





resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.terraform-bucket.bucket
  source = "D:/terraform/tf-aws-project1/index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
    bucket = aws_s3_bucket.terraform-bucket.bucket
  source = "D:/terraform/tf-aws-project1/style.css"
  key = "style.css"
  content_type = "text/css"
}



output "name" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}