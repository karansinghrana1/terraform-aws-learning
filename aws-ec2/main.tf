terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "terraform-server-02" {
  ami = "ami-00d8aa800578d8b12"
  instance_type = "t3.small"

  tags = {
    Name = "server from CLI"
  }
}