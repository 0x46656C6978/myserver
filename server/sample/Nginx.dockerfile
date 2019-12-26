FROM alpine:3.9
LABEL Maintainer="Dat Nguyen <kcboi95@gmail.com>" \
      Description="Lightweight container with Apache & PHP-FPM 7.1 based on Alpine Linux."

# Install packages
RUN apk add --no-cache \
    bash \
    curl \
    gcc \
    make \
    musl-dev \
    nano \
    nginx \
    openssl \
    php7 \
    php7-apache2 \
    php7-apcu \
    php7-bcmath \
    php7-cli \
    php7-ctype \
    php7-common \
    php7-curl \
    php7-dev \
    php7-fileinfo \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-opcache \
    php7-openssl \
    php7-pdo_mysql \
    php7-pear \
    php7-pecl-redis \
    php7-phar \
    php7-session \
    php7-simplexml \
    php7-soap \
    php7-tokenizer \
    php7-xdebug \
    php7-xml \
    php7-xmlreader \
    php7-xmlrpc \
    php7-xmlwriter \
    php7-xsl \
    php7-zip \
    supervisor \
    vim

RUN echo "" \
    # Install composer
&&  wget http://getcomposer.org/composer.phar -O /usr/local/bin/composer \
&&  chmod +x /usr/local/bin/composer \
    # Create nginx directory for nginx.pid file
&&  mkdir -p /run/nginx/ \
    # Add application
&&  mkdir -m 777 /var/www/html \
    # Clean cache
&&  rm -rf /tmp/*

#USER apache
WORKDIR /var/www/html
EXPOSE 80 443 9000
COPY /server/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
