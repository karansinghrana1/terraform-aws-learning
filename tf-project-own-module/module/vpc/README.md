# Terraform AWS VPC Infrastructure

## Overview

This project provisions a basic AWS VPC networking infrastructure with:

- A custom VPC
- Public and private subnets
- Internet Gateway
- Public route table
- Route table associations for public subnets

The infrastructure provides a foundation for deploying AWS resources such as EC2 instances and other services in a structured public/private network architecture.


##usage

'''
module "my-vpc" {
  source = "module url"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "your_VPC_name"
  }
  subnet_config = {
    public-subnet = {
        cidr_block = "10.0.0.0/24"
        az = "us-east-1a"
        ## To set subnet as public, default is priivate
        public = true
    }

    private-subnet = {
        cidr_block = "10.0.1.0/24"
        az = "us-east-1b"
    }

  }
}
'''