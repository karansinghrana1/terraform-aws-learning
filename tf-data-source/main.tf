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

# data "aws_ami" "name" {
#      most_recent      = true
#      owners = ["amazon"]
# }

# output "aws-ami" {
#   value = data.aws_ami.name.id
# }

# # security group

# data "aws_security_group" "name" {
#   tags = {
#     Name = "security group for data source"
#   }
# }

# output "aws-security-group" {
#   value = data.aws_security_group.name.id
# }

# # VPC

# data "aws_vpc" "name" {
#   tags = {
#     ENV = "PROD"
#   }
# }

# output "aws-vpc" {
#   value = data.aws_vpc.name.id
# }

# data "aws_availability_zones" "name" {
#   state = "available"
# }

# output "aws-az" {
#   value = data.aws_availability_zones.name
# }

# TO get account detail

# data "aws_caller_identity" "name" {
  
# }

# output "caller-info" {
#   value = data.aws_caller_identity.name
# }

# for region

# data "aws_region" "name" {}
# output "name" {
#   value = data.aws_region.name
# }

# resource "aws_instance" "data-sorce" {
#   ami = data.aws_ami.name.id
#   instance_type = "t3.small"

#   tags = {
#     Name = "ec2 for data source"
#   }
# }