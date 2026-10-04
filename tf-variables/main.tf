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

locals {
    owner ="abc"
    company = "tcs"
}

resource "aws_instance" "name" {
  ami = "ami-0d27e0fb3bac4d724"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.root_block_config.v_size
    volume_type = var.root_block_config.v_type
  }
    tags = merge(var.additional_tags,{
        Name="variable server"
        owner = locals.owner
        company=locals.company
    })

}