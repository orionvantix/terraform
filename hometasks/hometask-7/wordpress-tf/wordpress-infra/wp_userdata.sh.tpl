#!/bin/bash
set -xe

# Update packages and install Apache, PHP, and MariaDB client
dnf update -y
dnf install -y \
  httpd \
  php php-mysqlnd php-json php-mbstring php-xml php-gd \
  mariadb105 \
  tar wget

# Enable & start Apache
systemctl enable httpd
systemctl start httpd

# Prepare webroot
mkdir -p /var/www/html

# Remove Apache default test page
rm -f /var/www/html/index.html

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1

# Create wp-config.php with values passed from Terraform
cat > /var/www/html/wp-config.php <<EOF
<?php
define( 'DB_NAME',     '${db_name}' );
define( 'DB_USER',     '${db_user}' );
define( 'DB_PASSWORD', '${db_password}' );
define( 'DB_HOST',     '${db_host}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF

# Fix permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
