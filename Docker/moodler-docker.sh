mkdir moodle-docker
cd moodle-docker
nano Dockerfile

FROM php:7.4-apache
# Instalar as extensões PHP necessárias
RUN docker-php-ext-install mysqli pdo pdo_mysql
# Configurar o ambiente do Apache
RUN a2enmod rewrite
# Copiar o código do Moodle para o diretório web do Apache
COPY moodle /var/www/html/
# Definir permissões adequadas
RUN chown -R www-data:www-data /var/www/html/
# Expor a porta do Apache
EXPOSE 80
# Comando de inicialização do Apache
CMD ["apache2-foreground"]

docker build -t moodle-image .
docker run -d -p 8080:80 --name moodle-container moodle-image

