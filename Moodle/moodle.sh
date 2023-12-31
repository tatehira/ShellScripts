#!/bin/bash

# Solicita senha do banco de dados
clear
read -s -p "Digite a senha para o banco de dados moodle: " DB_PASSWORD
echo

# Solicita senha do sudo mysql
read -s -p "Digite a senha para o Banco dados MariaDB: " SUDO_PASSWORD
echo
clear
# Atualiza e instalar pacotes
sudo apt update && sudo apt upgrade -y
sudo apt install nmap ufw wget git -y
sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql php-gd php-xml php-curl php-intl php-zip php-xmlrpc php-mbstring php-soap -y
sudo rm /var/www/html/index.html

# Criar o banco de dados e usuário
sudo mysql -u root -p"$SUDO_PASSWORD" -e "CREATE DATABASE moodle_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; CREATE USER 'moodle_user'@'localhost' IDENTIFIED BY '$DB_PASSWORD'; GRANT ALL ON moodle_db.* TO 'moodle_user'@'localhost'; FLUSH PRIVILEGES;"

# Baixar e extrair o pacote do Moodle
wget https://download.moodle.org/download.php/direct/stable402/moodle-latest-402.tgz
tar -zxvf moodle-latest-402.tgz
sudo mv moodle /var/www/html/
sudo chmod 777 /var/www
sudo mkdir /var/www/moodledata
sudo chown -R www-data:www-data /var/www/html/moodle/ /var/www/moodledata
sudo chmod -R 755 /var/www/html/moodle/
sudo chmod 777 /var/www/moodledata

# Configura o VirtualHost do Apache
CONF_CONTENT="<VirtualHost *:80>
    ServerAdmin seu_email
    DocumentRoot /var/www/html/moodle
    ServerName seu_domínio

    <Directory /var/www/html/moodle>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"
echo "$CONF_CONTENT" | sudo tee /etc/apache2/sites-available/moodle.conf > /dev/null

# Injeta o valor 700 no max_input_vars 
sudo sed -i 's/^;max_input_vars = 1000/max_input_vars = 7000/' /etc/php/8.2/apache2/php.ini

# Habilita o site do Moodle e reiniciar o Apache
sudo a2ensite moodle.conf
sudo systemctl restart apache2

# Limpa o console e exibe na tela o IP do servidor
clear
ip=$(hostname -I | awk '{print $1}')
echo "Acesse o moodle pelo seguinte link: http://$ip/moodle"