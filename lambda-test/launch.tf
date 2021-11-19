

provider "aws" {
   region = "eu-west-1"
}

resource "aws_lambda_function" "myLambda" {
  function_name = "hello"
  s3_bucket     = "jensmaes-s3-terraform-bucket-lab"
  s3_key        = "lambda.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello.handler"
  runtime       = "python3.8"
}

 # IAM role which dictates what other AWS services the Lambda function
 # may access.
resource "aws_iam_role" "lambda_role" {
   name = "role_lambda"

   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

 # HTTP API

 resource "random_id" "id" {
	byte_length = 8
}
resource "aws_apigatewayv2_api" "api" {
	name          = "api-${random_id.id.hex}"
	protocol_type = "HTTP"
	target        = aws_lambda_function.myLambda.arn
}

# Permission
resource "aws_lambda_permission" "apigw" {
	action        = "lambda:InvokeFunction"
	function_name = aws_lambda_function.myLambda.arn
	principal     = "apigateway.amazonaws.com"

	source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}