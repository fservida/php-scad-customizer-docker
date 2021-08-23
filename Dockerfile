FROM php:7-apache

RUN apt update && apt install composer

COPY most-3-d-customizer/* /var/www/html/
WORKDIR /var/www/html/
RUN composer install

