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
  project = "project-01"
}

resource "aws_vpc" "myVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "mySubnet" {
  vpc_id = aws_vpc.myVPC.id
  cidr_block = "10.0.${count.index +1 }.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  count = 2

  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

#creating 4 aws instance

# resource "aws_instance" "name" {
#   ami = "ami-0d27e0fb3bac4d724"
#   instance_type = "t3.micro"

#   count = 4

#   subnet_id = element(aws_subnet.mySubnet[*].id,count.index % length(aws_subnet.mySubnet))

#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }

#creating 2 aws instance
# resource "aws_instance" "name" {
#   count = length(var.ec2_cinfig)
#   ami = var.ec2_cinfig[count.index].ami
#   instance_type = var.ec2_cinfig[count.index].instance_type

#   subnet_id = element(aws_subnet.mySubnet[*].id,count.index % length(aws_subnet.mySubnet))

  
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }

#creating 2 aws instance using map
resource "aws_instance" "name" {
  for_each = var.ec2_map

  ami = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.mySubnet[*].id,index(keys(var.ec2_map), each.key) % length(aws_subnet.mySubnet))

  
  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}
