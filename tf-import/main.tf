terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "name" {
  
}



# run in command
# terraform import aws_s3_bucket.name(resorce name) bucketid(whichg we need to track)