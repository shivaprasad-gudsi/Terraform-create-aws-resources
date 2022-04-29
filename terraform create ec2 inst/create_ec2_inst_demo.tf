provider "aws" {
  region     = "us-east-1"
  access_key = "XXXXXXXXXXXX"
  secret_key = "XXXXXXXXYYYYYYYYYYYYYYYY"
}

resource "aws_instance" "my-ec2" {
  ami           = "ami-0c02fb55956c7d316" # us-east-1
  instance_type = "t2.micro"
  key_name      = "ec2instance"
  vpc_security_group_ids = [
    "sg-0e300478ae2a8e790"
  ]
  user_data       = "${file("init.sh")}"
}
