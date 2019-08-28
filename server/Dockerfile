FROM alpine:3.7
LABEL Maintainer="Dat Nguyen <kcboi95@gmail.com>" \
      Description="Lightweight container with Nginx 1.14 & PHP-FPM 7.1 based on Alpine Linux."

# Copy required files
COPY etc /tmp/etc
COPY inc /tmp/inc
RUN ls -la /tmp
# Install packages
RUN apk add \
    php7 \
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
    supervisor \
    curl \
    nginx \
    nginx-mod-http-headers-more

RUN echo "" && \
    # Install composer
    wget http://getcomposer.org/composer.phar -O /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    # Configure nginx
    # Create nginx directory for nginx.pid file
    mkdir -p /run/nginx && \
    # Configure php-fpm
    cp /tmp/etc/php7/fpm-pool.conf /etc/php7/php-fpm.d/www.conf && \
    cp /tmp/etc/php7/php.ini /etc/php7/conf.d/99.custom.ini && \
    # Add application
    mkdir -p /var/www/html && \
    # Clean cache
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

WORKDIR /var/www/html

EXPOSE 80 443 9000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]