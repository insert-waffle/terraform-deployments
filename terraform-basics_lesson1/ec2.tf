provider "aws" {
	region = "eu-west-1"
}

resource "aws_instance" "cloud-example" {
	ami = "ami-016ee74f2cf016914"
	instance_type = "t3.micro"
	subnet_id = var.vpc-subnet-1a
	vpc_security_group_ids = [
		"sg-067833e558096224a",
		"sg-0010525517c718fb0"
	]
	tags = {
	  "Name" = "terraform-instance-3"
	}
}