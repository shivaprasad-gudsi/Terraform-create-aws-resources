provider "aws" {
  region     = "ap-south-1"
  access_key = "XXXXXXXXX"
  secret_key = "XXXXXXXXXXYYYYYYYYYYY"
}

resource "aws_instance" "ap-south-1" {
  ami           = "ami-0e0ff68cb8e9a188a" # ap-south-1
  instance_type = "t2.micro"
  key_name      = "secondinstance"
  vpc_security_group_ids = [
    "sg-07143c4b47cdbf99e"
  ]
  user_data       = "${file("init.sh")}"
}

resource "aws_s3_bucket" "shgudsi-bucket1" {
  bucket = "shgudsi-bucket1"
  #acl    = "private"

  tags = {
    Name        = "My Terraform bucket"
    Environment = "Dev-Env"
  }
}
