#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 mysql-client mysql-server php7.4 libapache2-mod-php7.4 -y
sudo apt install sudo php7.4-cli php7.4-gd php7.4-curl php7.4-intl php7.4-mbstring php7.4-xml php7.4-zip graphviz aspell ghostscript clamav php7.4-pspell php7.4-mysql php7.4-xmlrpc php7.4-ldap php7.4-soap -y
sudo mysql_secure_installation
sudo mysql -u root -p -e "CREATE DATABASE moodle;"
sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost' IDENTIFIED BY '12345678';"
sudo mysql -u root -p -e "FLUSH PRIVILEGES;"
cd /opt
git clone https://github.com/moodle/moodle.git
sudo mv moodle /var/www/html/
sudo mkdir /var/moodledata
sudo chown -R www-data /var/moodledata
sudo chown -R www-data:www-data /var/www/html/moodle/
sudo chmod -R 777 /var/moodledata /var/www/html/moodle/
sudo systemctl restart apache2
clear
ip=$(hostname -I | awk '{print $1}')
echo "Acesse o moodle pelo seguinte link: https://$ip"
