FROM php:7.3.27-fpm-alpine3.13
RUN apk --no-cache add postgresql-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql
