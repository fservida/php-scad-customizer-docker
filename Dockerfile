FROM php:7-apache

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-source delete

RUN apt-get update && apt-get install -y \
        openscad \
        povray

COPY most-3-d-customizer /var/www/html/most-3d-customizer
RUN chmod 777 /var/www/html/most-3d-customizer/files/
WORKDIR /var/www/html/most-3d-customizer/
RUN composer install

