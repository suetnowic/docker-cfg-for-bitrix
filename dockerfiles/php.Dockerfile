FROM php:7.4-fpm-alpine

RUN apk update && \
    apk -y install \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        libzip-dev \
        unzip

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions pdo pdo_mysql mysqli pcntl intl opcache gd zip soap

WORKDIR /var/www/html

RUN curl --sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

COPY . /var/www/html

#RUN composer install --no-dev

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000
