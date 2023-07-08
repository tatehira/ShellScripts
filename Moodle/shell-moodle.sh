!#/bin/bash/
echo -n "Vamos começar a instalação!" 
for i in $(seq 1 1 3);
do
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
read -p "Enter the domain name for Moodle (e.g., moodle.yourdomain.com): " domain
apt update && apt upgrade -y
apt install apache2 git php -y
cat > /etc/apache2/sites-available/$domain.conf <<EOF
<VirtualHost *:80>
ServerAdmin admin@$domain
DocumentRoot /var/www/html/moodle/
ServerName $domain

<Directory /var/www/html/moodle/>
Options +FollowSymlinks
AllowOverride All
Require all granted
</Directory>

ErrorLog \${APACHE_LOG_DIR}/moodle.error.log
CustomLog \${APACHE_LOG_DIR}/moodle.access.log combined

</VirtualHost>
EOF
apt-get install mlocate
updatedb
locate a2enmod
sudo a2enmod rewrite
sudo sudo a2ensite $domain.conf
systemctl reload apache2
sed -i 's/^max_input_vars = .*/max_input_vars = 7000/' /etc/php/7.4/apache2/php.ini
systemctl restart apache2
apt install mariadb-server -y
mysql <<EOF
CREATE DATABASE moodle_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'moodle_user'@'localhost' IDENTIFIED BY 'm0d1fyth15';
GRANT ALL ON moodle_db.* TO 'moodle_user'@'localhost';
FLUSH PRIVILEGES;
\q
EOF
apt install git graphviz aspell ghostscript php7.4-{pspell,curl,gd,intl,mysql,xml,xmlrpc,ldap,zip,soap,mbstring} -y
cd /opt
git clone https://github.com/moodle/moodle.git
cd moodle/
git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE
git checkout MOODLE_400_STABLE
cp -R /opt/moodle/ /var/www/html/moodle/
mkdir /var/www/moodledata
chmod -R 777 /var/www/moodledata/
chown -R www-data. /var/www/moodledata/ /var/www/html/moodle/
clear
ip=$(hostname -I | awk '{print $1}')
echo "Acesse o Moodle pelo seguinte link: https://$ip/moodle"