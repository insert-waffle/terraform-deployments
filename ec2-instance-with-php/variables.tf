variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "INSTANCE_NAME" {
  default = "terraform-deployment"
}

variable "BUCKET_NAME" {
  default = "jensmaes-bucket-terraform-lab"
}

variable "BUCKET_TAG_NAME" {
  default = "Terraform - Assignment lab 1"
}

variable "INSTANCE_AMI" {
  default = "ami-08edbb0e85d6a0a07"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}