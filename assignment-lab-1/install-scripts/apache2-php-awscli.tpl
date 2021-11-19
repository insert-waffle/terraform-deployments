#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt install -y php libapache2-mod-php
sudo apt install -y awscli
aws s3 cp s3://${s3_bucket_name}/index.php /var/www/html
sed -i "s#{LAMBDA_FUNCTION_URL}#${apigateway}#g" /var/www/html/index.php
sed -i "s#{S3_BUCKET_NAME}#${s3_bucket_name}#g" /var/www/html/index.php 