FROM alpine:3.7
LABEL Maintainer="Dat Nguyen <kcboi95@gmail.com>" \
      Description="Lightweight container with Apache & PHP-FPM 7.1 based on Alpine Linux."

# Install packages
RUN apk add --no-cache \
    apache2 \
    apache2-proxy \
    apache2-ssl \
    apache2-utils \
    bash \
    curl \
    gcc \
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
    php7-mcrypt \
    php7-mysqli \
    php7-pdo_mysql \
    php7-pear \
	php7-phar \
    php7-opcache \
    php7-session \
    php7-simplexml \
    php7-soap \
    php7-xdebug \
    php7-zip \
    php7-xml \
    php7-xmlreader \
    php7-xmlrpc \
    php7-xmlwriter \
    php7-xsl \
    make \
    musl-dev \
    nano \
    supervisor \
    vim

RUN echo "" \
&&  pecl install apcu \
&&  pecl install apcu_bc \
    # Install composer
&&  wget http://getcomposer.org/composer.phar -O /usr/local/bin/composer \
&&  chmod +x /usr/local/bin/composer \
    # Create apache2 directory for httpd.pid file
&&  mkdir -p /run/apache2 \
    # Add application
&&  mkdir -p /var/www/html \
    # Clean cache
&&  pecl clear-cache \
&&  rm -rf /tmp/*


WORKDIR /var/www/html
EXPOSE 80 443 9000
COPY /server/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]