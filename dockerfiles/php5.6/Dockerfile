FROM php:5.6-fpm-alpine
RUN apk --no-cache add postgresql-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql
