#!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root." 
   exit 1
fi

# Atualiza o sistema
apt update
apt upgrade -y

# Instala os pacotes necessários
apt install -y apache2 mariadb-server php php-mysql libapache2-mod-php unzip

# Configura o MariaDB
mysql_secure_installation

# Cria o banco de dados e o usuário para o Moodle
mysql -u root -p -e "CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root -p -e "CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost';"
mysql -u root -p -e "FLUSH PRIVILEGES;"

# Baixa e descompacta o Moodle
cd /var/www/html
git clone https://github.com/moodle/moodle.git
mv moodle/* .
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Reinicia o Apache
systemctl restart apache2

echo "A instalação do Moodle foi concluída. Acesse o site para continuar com a configuração."
