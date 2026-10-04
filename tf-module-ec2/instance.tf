provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnets = [
    "10.0.1.0/24"
  ]

  private_subnets = [
    "10.0.2.0/24"
  ]

  tags = {
    Name = "module-vpc"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.1"

  name = "module-instance"

  ami           = "ami-0d27e0fb3bac4d724"
  instance_type = "t3.nano"

  vpc_security_group_ids = [
    module.vpc.default_security_group_id
  ]

  subnet_id = module.vpc.public_subnets[0]

  associate_public_ip_address = true

  tags = {
    Name        = "module-project"
    Environment = "dev"
  }
}