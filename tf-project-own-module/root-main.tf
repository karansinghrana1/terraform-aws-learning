module "my-vpc" {
  source = "./module/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "Own module vpc"
  }
  subnet_config = {
    public-subnet-1 = {
        cidr_block = "10.0.0.0/24"
        az = "us-east-1a"
        public = true
    }

    public-subnet-2 = {
        cidr_block = "10.0.2.0/24"
        az = "us-east-1a"
        public = true
    }

    private-subnet = {
        cidr_block = "10.0.1.0/24"
        az = "us-east-1b"
    }

  }
}