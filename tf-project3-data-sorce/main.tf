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

data "aws_subnet" "name" {
  tags = {
    Project = "tf-project"
  }
}

data "aws_security_group" "name" {
  tags = {
    Project = "tf-project"
  }
}


resource "aws_instance" "name" {
  ami = "ami-0d27e0fb3bac4d724"
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.name.id
  vpc_security_group_ids = [data.aws_security_group.name.id]
    tags = {
    Name = "ec2 from data source project"
  }

}