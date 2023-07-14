mkdir moodle-docker
cd moodle-docker
nano Dockerfile

FROM php:7.4-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite
COPY moodle /var/www/html/
RUN chmod 777 /var/www 
RUN chown -R www-data:www-data /var/www/html/moodle
RUN chmod -R 755 /var/www/html/moodle 
EXPOSE 80
CMD ["apache2-foreground"]

docker build -t moodle-image .
docker run -d -p 8080:80 --name moodle-container moodle-image

