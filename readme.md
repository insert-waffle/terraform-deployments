# Cloud Computing
A course given on Thomas More, Campus de Nayer. In this github repository are my terraform scripts for AWS usage.
Everything is as-is, and I will not provide support on it.

## ec2-instance-with-php
The infrastructure will hosts a simple php application. The php application will invoke a lambda function (which replies with the EC2 instance IP address) and show an image stored on an S3 bucket. Everything important naming-related is in the `variables.tf`. The private ssh key can be extracted from the tfstate, should you need to connect to the EC2 instance.

### Creates the following resources on AWS:
1. S3 bucket with 2 files (index.php and image.php)
2. IAM role for EC2 instances to be able to use awscli to download files from the S3 bucket
3. VPC, subnet, internet gateway, route table and a security group
4. SSH key for the EC2 instance
5. EC2 t2.micro (configurable) instance, accessible with the previously created SSH key, in the created VPC's subnet.
6. Lambda function with Python code and an HTTP API gateway which responds with the EC2 instance IP

### How to test?
Once you ran `terraform init` and `terraform apply`, you get an output of the EC2 instance's IP address (please wait for the userdata to properly load.) When you visit the index.php page on the webserver, you should see the IP of the instance (called by the Lambda function) and an image hosted on the S3 bucket.

The `index.php` page is changed in the last stage of the userdata script, where set "variables" are changed using `sed` to change the S3 bucket name and the lambda URL.
