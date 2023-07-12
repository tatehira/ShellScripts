#!/bin/bash

# Atualizar o sistema
sudo apt update
sudo apt upgrade -y

# Instalar os pacotes necessários
sudo apt install apache2 mariadb-server unzip php php-cli php-gd php-curl php-intl php-mbstring php-xml php-zip -y

# Configurar o banco de dados
sudo mysql_secure_installation

# Criar um banco de dados e um usuário para o Moodle
sudo mysql -u root -p -e "CREATE DATABASE moodle;"
sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost' IDENTIFIED BY '12345678';"
sudo mysql -u root -p -e "FLUSH PRIVILEGES;"

# Baixar o pacote do Moodle 
git clone https://github.com/moodle/moodle.git

# Descompactar o pacote do Moodle
sudo mv moodle /var/www/html/
sudo mkdir /var/moodledata

# Configurar as permissões
sudo chown -R www-data /var/moodledata
sudo chmod -R 777 /var/moodledata
sudo chown -R www-data:www-data /var/www/html/moodle/
sudo chmod -R 777 /var/www/html/moodle/

# Reiniciar o serviço do Apache
sudo systemctl restart apache2

clear
# Acessar o Moodle pelo navegador
echo "Acesse o Moodle pelo navegador e siga as instruções de instalação."

