#!/bin/bash

read -p "Digite o valor de 'yourdomain': " yourdomain
clear
function exibir_barra_carregamento() {
    local progresso=0
    local tempo_espera=1
    local total_etapas=$1

    dialog --title "Instalação em andamento" --gauge "Aguarde enquanto a instalação é concluída..." 10 70 0

    while [[ $progresso -lt $total_etapas ]]; do
        sleep $tempo_espera
        progresso=$((progresso + 1))
        echo $progresso | dialog --title "Instalação em andamento" --gauge "Aguarde enquanto a instalação é concluída..." 10 70 $progresso
    done

    sleep $tempo_espera
    echo "100" | dialog --title "Instalação em andamento" --gauge "Aguarde enquanto a instalação é concluída..." 10 70 100
    sleep $tempo_espera
    clear
    echo "A instalação foi concluída!"
}

{
    function realizar_instalacao() {
        apt update && apt upgrade -y
        apt install apache2 php -y
        clear
        CONF_CONTENT="<VirtualHost *:80>
        ServerAdmin admin@$yourdomain
        DocumentRoot /var/www/html/moodle/
        ServerName moodle.$yourdomain

        <Directory /var/www/html/moodle/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/moodle.error.log
        CustomLog \${APACHE_LOG_DIR}/moodle.access.log combined

        </VirtualHost>"
        echo "$CONF_CONTENT" | sudo tee /etc/apache2/sites-available/moodle.$yourdomain.conf
        if pgrep -x "nano" >/dev/null; then
            echo "Saindo do editor Nano..."
            sleep 1
            tmux send-keys -t 0.0 C-x
        fi
        clear
        apt-get install mlocate
        updatedb
        a2enmod rewrite
        sudo a2enmod rewrite
        systemctl restart apache2
        sudo a2ensite moodle.$yourdomain
        systemctl reload apache2
        clear
        NEW_VALUE="7000"
        PHP_INI_FILE="/etc/php/7.4/apache2/php.ini"
        sudo sed -i "s/^\(max_input_vars = \).*/\1$NEW_VALUE/" "$PHP_INI_FILE"
        echo "O valor de 'max_input_vars' foi alterado para $NEW_VALUE no arquivo php.ini."
        systemctl restart apache2
        apt install mariadb-server -y
        clear
        mysql <<EOF
        CREATE DATABASE moodle_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        CREATE USER 'moodle_user'@'localhost' IDENTIFIED BY 'm0d1fyth15';
        GRANT ALL ON moodle_db.* TO 'moodle_user'@'localhost';
        FLUSH PRIVILEGES;
        \q
        EOF
        apt install git graphviz aspell ghostscript php7.4-{pspell,curl,gd,intl,mysql,xml,xmlrpc,ldap,zip,soap,mbstring} -y
        clear
        sudo apt install git -y
        clear
        cd /opt
        git clone https://github.com/moodle/moodle
        clear
        cd moodle/
        git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE
        git checkout MOODLE_400_STABLE
        cp -R /opt/moodle/ /var/www/html/moodle/
        mkdir /var/www/moodledata
        chmod -R 777 /var/www/moodledata/
        chown -R www-data. /var/www/moodledata/ /var/www/html/moodle/
        clear
    }

    realizar_instalacao

} | exibir_barra_carregamento 20
ip=$(hostname -I | awk '{print $1}')
echo "Acesse o Moodle pelo seguinte link: https://$ip/moodle"
