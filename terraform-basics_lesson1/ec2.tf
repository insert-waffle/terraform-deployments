# Creates an EC2 instance in eu-west-1, in subnet 1a with the 2 security groups
provider "aws" {

  region = "eu-west-1"

}

resource "aws_instance" "cloud-example-3" {
  ami           = "ami-08edbb0e85d6a0a07"
  instance_type = "t2.micro"
  subnet_id     = var.vpc-subnet-1a
  vpc_security_group_ids = [

    "sg-067833e558096224a",
    "sg-0010525517c718fb0"

  ]
  user_data = file("install-files/apache2.sh test")
  tags = {

    "Name" = "terraform-instance-4"

  }

  # Allows us to connect using our currently available AWS SSH key
  key_name = "JensMaes"
}