#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt install -y php libapache2-mod-php php-mysql
sudo apt install -y awscli
aws s3 cp s3://jensmaes-s3-terraform-bucket-lab/index.php /var/www/html