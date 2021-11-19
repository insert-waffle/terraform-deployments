provider "aws" {

  region = var.AWS_REGION

}

resource "aws_instance" "autodeploy-webserver" {
  ami                  = "ami-08edbb0e85d6a0a07"
  instance_type        = "t2.micro"
  subnet_id = aws_subnet.terraform-subnet-public-1.id
  iam_instance_profile = aws_iam_instance_profile.ec2-s3_profile.name
  vpc_security_group_ids = [
    aws_security_group.ssh-http-allowed.id
  ]
  user_data = templatefile("install-scripts/apache2-php-awscli.tpl", { s3_bucket_name = aws_s3_bucket.b1.bucket })
  tags = {
    "Name" = "terraform-instance-4"
  }
  key_name = aws_key_pair.generated_key.key_name
}