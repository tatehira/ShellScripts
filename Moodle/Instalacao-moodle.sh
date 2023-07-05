!#/bin/bash/
clear
echo -n "Vamos começar a instalação!" 
for i in $(seq 1 1 5);
do
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
apt update && apt upgrade -y
apt install apache2 php -y
clear
echo -n "Siga a (1 - ETAPA) do arquivo etapas.txt" 
for i in $(seq 1 1 5);
do
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
clear 
nano /etc/apache2/sites-available/moodle.yourdomain.com.conf
clear
apt-get install mlocate
updatedb
a2enmod rewrite
sudo a2enmod rewrite
systemctl restart apache2
sudo a2ensite moodle.yourdomain.com
systemctl reload apache2
clear
echo -n "Siga a (2 - ETAPA) do arquivo etapas.txt" 
for i in $(seq 1 1 8);
do
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
clear 
nano /etc/php/7.4/apache2/php.ini
systemctl restart apache2
apt install mariadb-server -y
clear
echo -n "Siga a (3 - ETAPA) do arquivo etapas.txt" 
for i in $(seq 1 1 8);
do # Faça
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
clear
mysql
apt install git graphviz aspell ghostscript php7.4-{pspell,curl,gd,intl,mysql,xml,xmlrpc,ldap,zip,soap,mbstring} -y
clear
sudo apt install git -y
clear
cd /opt
git clone https://github.com/moodle/moodle
clear
echo -n "Fazendo download o moodle via git" 
for i in $(seq 1 1 8);
do # Faça
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
clear
cd moodle/
git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE
git checkout MOODLE_400_STABLE
cp -R /opt/moodle/ /var/www/html/moodle/
mkdir /var/www/moodledata
chmod -R 777 /var/www/moodledata/
chown -R www-data. /var/www/moodledata/ /var/www/html/moodle/
clear
echo "Vou te mostrar o IP e voce copia e cole na URL" 
echo "Importante colocar '/moodle' no final." 
for i in $(seq 1 1 5);
do # Faça
	echo -n " ." 
	sleep 01
	echo -ne "" 
done 
clear
ip a