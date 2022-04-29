provider "aws" {
  region     = "ap-south-1"
  access_key = "XXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXYYYYYYYYYYY"
}

resource "aws_instance" "ap-south-1" {
  ami           = "ami-0e0ff68cb8e9a188a" # ap-south-1
  instance_type = "t2.micro"
  key_name      = "secondinstance"
  vpc_security_group_ids = [
    "sg-07143c4b47cdbf99e"
  ]
  user_data       = "${file("ec2userdata.sh")}"
}

resource "aws_s3_bucket" "shgudsi-bucket1" {
  bucket = "shgudsi-bucket1"
  #acl    = "private"

  tags = {
    Name        = "My Terraform bucket"
    Environment = "Dev-Env"
  }
}


provider "aws" {
  region     = "ap-southeast-1"
  access_key = "XXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXYYYYYYYYYYY"
  alias = "apsoutheast1"
}


resource "aws_instance" "ap-southeast-1" {
  ami           = "ami-02f47fa62c613af4" # ap-southeast-1
  instance_type = "t2.micro"
  provider = aws.apsoutheast1
}

resource "aws_s3_bucket" "shgudsi-bucket2" {
  bucket = "shgudsi-bucket2"
  #acl    = "private"

  tags = {
    Name        = "Second Bucket"
    Environment = "Prod"
  }
}

resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev-vpc"
  }
}


resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_db_instance" "myterraformdb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.19"
  instance_class       = "db.t3.micro"
  db_name                 = "myterraformdb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}
