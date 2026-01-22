#!/bin/bash
dnf update -y
dnf install -y httpd php php-mysqlnd mariadb

systemctl enable httpd
systemctl start httpd

cd /var/www/html

# Download WordPress
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .

