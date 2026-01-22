#!/bin/bash
dnf update -y
dnf install -y httpd php php-mysqlnd mariadb105

systemctl enable httpd
systemctl start httpd

mkdir -p /var/www/html
cd /var/www/html

curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

chown -R apache:apache /var/www/html