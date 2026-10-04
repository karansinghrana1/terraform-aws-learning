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


resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name ="test-vpc"
  }
}

resource "aws_subnet" "test-subnet" {
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "test-subnet"
  }
}

resource "aws_security_group" "test" {
#inbound rule
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#outbound rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "test"
    }
}

resource "aws_instance" "ec2-from-vpc" {
  ami = "ami-0d27e0fb3bac4d724"
  instance_type = "t3.nano"
  subnet_id = aws_subnet.test-subnet.id
  associate_public_ip_address = false
#   vpc_security_group_ids = [aws_security_group.test.id]
  # depending 
  depends_on = [ aws_security_group.test ]

  tags = {
    Name = "ec2 from test"
  }

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    # ignore_changes = [  ]
    # replace_triggered_by = [  ]

    precondition {
      condition = aws_security_group.test.id != ""
      error_message = "SG id must not be blank"
    }
    postcondition {
      condition = self.public_ip != ""
      error_message = "public id not present"
    }
  }
}