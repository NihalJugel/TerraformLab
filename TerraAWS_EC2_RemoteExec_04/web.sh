#!/bin/bash
apt update
apt install wget unzip apache2 -y
systemctl start apache2
systemctl enable apache2
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip 2117_infinite_loop.zip
rm 2117_infinite_loop.zip
mv 2117_infinite_loop/* /var/www/html/
rm -rf 2117_infinite_loop
systemctl restart apache2
