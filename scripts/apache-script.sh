#!/bin/bash
sudo yum -y update
echo "Installing Java"
sudo yum -y install java-21-amazon*
#echo "Installing GIT"
#sudo yum -y install git

sudo fallocate -l 1G /swapfile_extend_1GB
sudo mount -o remount,size=5G /tmp/

sudo yum install -y httpd
sudo service httpd start
sudo chkconfig httpd on
sudo echo "<h1> NODE $HOST $HOSTNAME  </h1>" > /var/www/html/index.html

