terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }

  backend "s3" {
    bucket = "terraform-bucket-951d6ac5a5dc0ae8"
    key = "backend-tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform-server-02" {
  ami = "ami-00d8aa800578d8b12"
  instance_type = "t3.nano"

  tags = {
    Name = "server from CLI"
  }
}