FROM alpine:3.7
LABEL Maintainer="Dat Nguyen <kcboi95@gmail.com>" \
      Description="Lightweight container with Nginx 1.14 & PHP-FPM 7.1 based on Alpine Linux."

# Install packages
RUN apk add \
    php5 \
    php5-apcu \
    php5-bcmath \
    php5-common \
    php5-curl \
    php5-dev \
    php5-fpm \
    php5-gd \
    php5-intl \
    php5-json \
    php5-mcrypt \
    php5-mysql \
    php5-mysqli \
    php5-opcache \
    php5-pdo_mysql \
    php5-soap \
    php5-zip \
    php5-xml \
    php5-xmlrpc \
    php5-xsl

RUN apk add \
    php7 \
    php7-apcu \
    php7-bcmath \
    php7-cli \
    php7-common \
    php7-curl \
    php7-dev \
    php7-fpm \
    php7-gd \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqli \
    php7-pdo_mysql \
	php7-phar \
    php7-opcache \
    php7-session \
    php7-soap \
    php7-xdebug \
    php7-zip \
    php7-xml \
    php7-xmlrpc \
    php7-xsl

RUN apk add supervisor curl nginx nginx-mod-http-headers-more


# Install ioncube for PHP
COPY inc/ioncube /tmp/ioncube
RUN cd /tmp/ && \
    # Copy ioncube .so files to correct PHP version directory
    cp ioncube/ioncube_loader_lin_5.6.so /usr/lib/php5/modules && \
    chmod 755 /usr/lib/php5/modules/ioncube_loader_lin_5.6.so && \
    cp ioncube/ioncube_loader_lin_7.1.so /usr/lib/php7/modules && \
    chmod 755 /usr/lib/php7/modules/ioncube_loader_lin_7.1.so && \
    # Remove ioncube directory
    rm -Rf /tmp/ioncube


# Create ini file for PHP to load ioncube at startup
RUN cd /etc/php5/conf.d/ && echo "zend_extension=ioncube_loader_lin_5.6.so" >> 00-ioncube.ini && \
    cd /etc/php7/conf.d/ && echo "zend_extension=ioncube_loader_lin_7.1.so" >> 00-ioncube.ini

RUN rm -rf /tmp/*

# Configure nginx
# Create nginx directory for nginx.pid file
RUN mkdir -p /run/nginx

# Configure php-fpm
COPY etc/php7/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY etc/php7/php.ini /etc/php7/conf.d/99.custom.ini

COPY etc/php5/fpm-pool.conf /etc/php5/php-fpm.conf
COPY etc/php5/php.ini /etc/php5/conf.d/99.custom.ini

# Setup xdebug for php5
COPY inc/php5_xdebug.so /usr/lib/php5/modules/xdebug.so
RUN cd /etc/php5/conf.d/ && echo "zend_extension=xdebug.so" >> xdebug.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN rm -rf /var/cache/apk/*

EXPOSE 80 443 9000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]