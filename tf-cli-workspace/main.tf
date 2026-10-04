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
    bucket = "terraform-bucket-prod-${random_id.rand_id.hex}" 
    force_destroy = true
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.terraform-bucket.bucket
  source = "d:/terraform/mybucket.txt"
  key = "mydata.txt"
}


output "name" {
  value = random_id.rand_id.hex
}



# commans
# terraform workspace
# terraform workspace list
# terraform workspace show
# terraform workspace new <workspace name>
# terraform workspace select <workspace name>
# <workspace name delete <workspace name>
