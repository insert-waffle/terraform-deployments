provider "aws" {

  region = "eu-west-1"

}

# Creating S3 bucket & uploading files
resource "aws_s3_bucket" "b1" {

  bucket = "jensmaes-s3-terraform-bucket-lab"
  acl    = "private" # or can be "private"
  tags = {
    Name = "Terraform - Assignment lab 1"
  }
}

resource "aws_s3_bucket_object" "b1" {

  for_each = fileset("upload/", "*")
  bucket   = aws_s3_bucket.b1.id
  key      = each.value
  source   = "upload/${each.value}"
  etag     = filemd5("upload/${each.value}")

}

resource "aws_instance" "autodeploy-webserver" {
  ami           = "ami-08edbb0e85d6a0a07"
  instance_type = "t2.micro"
  subnet_id     = var.vpc-subnet-1a
  iam_instance_profile = "EC2-S3ADMIN"
  vpc_security_group_ids = [

    "sg-067833e558096224a",
    "sg-0010525517c718fb0"

  ]
  user_data = file("install-scripts/apache2-php-awscli.sh")
  tags = {

    "Name" = "terraform-instance-4"

  }

  # Allows us to connect using our currently available AWS SSH key
  key_name = "JensMaes"
}