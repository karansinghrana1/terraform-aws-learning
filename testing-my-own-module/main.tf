provider "aws" {
  region = "us-east-1"
}

module "karan-module-vpc" {
  source  = "karansinghrana1/karan-module-vpc/aws"
  version = "1.0.0"

  # insert the 2 required variables here
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "your-vpc-name"
  }

  subnet_config = {
    public-subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"

      # Set public = true to make this a public subnet
      public = true
    }

    private-subnet = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"

      # Set public = false for a private subnet
      public = false
    }
}
}

