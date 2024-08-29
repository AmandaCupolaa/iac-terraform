terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_iac_pri_ex1" {
   ami = "ami-0e86e20dae9224db8"
   instance_type = "t2.micro"

   tags = {
     Name= "ec2_iac_pri_ex1"
   }

   ebs_block_device {
     device_name = "/dev/sda1"
     volume_size = 30
     volume_type = "gp3"
   }

   key_name = "aula_iac"

    subnet_id = aws_subnet.subnet_pri.id

    associate_public_ip_address = false
}


resource "aws_instance" "ec2_iac_pub_ex1" {
   ami = "ami-0e86e20dae9224db8"
   instance_type = "t2.micro"

   tags = {
     Name= "ec2_iac_pub_ex1"
   }

   ebs_block_device {
     device_name = "/dev/sda1"
     volume_size = 30
     volume_type = "gp3"
   }

   key_name = "aula_iac"

    subnet_id = aws_subnet.subnet_pub.id

    associate_public_ip_address = true
}

resource "aws_subnet" "subnet_pri" {
  vpc_id = "vpc-006c7f6d131bb94f1"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name: "subnet_pri",
  }
}

resource "aws_subnet" "subnet_pub" {
  vpc_id = "vpc-006c7f6d131bb94f1"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name: "subnet_pub",
  }
}

resource "aws_vpc" "vpc_aula" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_aula"
  }
}