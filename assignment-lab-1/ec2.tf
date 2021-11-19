provider "aws" {

  region = var.AWS_REGION

}

resource "aws_instance" "autodeploy-webserver" {
  ami                    = var.INSTANCE_AMI
  instance_type          = var.INSTANCE_TYPE
  subnet_id              = aws_subnet.terraform-subnet-public-1.id
  iam_instance_profile   = aws_iam_instance_profile.ec2-s3_profile.name
  vpc_security_group_ids = [aws_security_group.ssh-http-allowed.id]
  user_data              = templatefile("install-scripts/apache2-php-awscli.tpl", { s3_bucket_name = aws_s3_bucket.b1.bucket, apigateway = aws_apigatewayv2_api.lambda-api.api_endpoint })
  tags = {
    "Name" = var.INSTANCE_NAME
  }
  key_name = aws_key_pair.generated_key.key_name
}