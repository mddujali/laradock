ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm-alpine

# ADD ./docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apk update

RUN apk upgrade

RUN mkdir -p /scripts

ADD ./docker/php/libraries.sh /scripts

RUN chmod +x /scripts/libraries.sh

RUN /scripts/libraries.sh

ARG XDEBUG_VERSION

ARG XDEBUG_START_WITH_REQUEST

ARG XDEBUG_DISCOVER_CLIENT_HOST

ARG XDEBUG_MODE

ARG XDEBUG_IDEKEY

ARG XDEBUG_CLIENT_HOST

ARG XDEBUG_CLIENT_PORT

RUN apk --no-cache add --virtual .build-deps \
    g++ \
    autoconf \
    make && \
    pecl install xdebug-$XDEBUG_VERSION && \
    docker-php-ext-enable xdebug && \
    apk del .build-deps && \
    rm -r /tmp/pear/* && \
    echo -e "xdebug.start_with_request=${XDEBUG_START_WITH_REQUEST}\n\
    xdebug.discover_client_host=${XDEBUG_DISCOVER_CLIENT_HOST}\n\
    xdebug.mode=${XDEBUG_MODE}\n\
    xdebug.log=/var/www/html/storage/logs/xdebug.log\n\
    xdebug.idekey=$XDEBUG_IDEKEY\n\
    xdebug.client_host=$XDEBUG_CLIENT_HOST\n\
    xdebug.client_port=$XDEBUG_CLIENT_PORT" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install PDFlib
# RUN set -ex && \
#     apk add --no-cache libstdc++ && \
#     curl -fSL -o pdflib.tar.gz https://www.pdflib.com/binaries/PDFlib/1000/PDFlib-10.0.0p1-Alpine-Linux-x64-php.tar.gz && \
#     tar -xzf pdflib.tar.gz && \
#     mv PDFlib-* pdflib && \
#     PHP_EXT_DIR=$(php-config --extension-dir) && \
#     PHP_MAIN_VERSION=$(php --version | grep -Eo '([0-9]{1,}\.)+[0-9]{1,}' | head -n1 | cut -d. -f1-2 | sed 's/\.//g') && \
#     cp pdflib/bind/php/php-${PHP_MAIN_VERSION}0-nts/php_pdflib.so $PHP_EXT_DIR && \
#     docker-php-ext-enable php_pdflib && \
#     rm pdflib.tar.gz && \
#     rm -r pdflib

WORKDIR /var/www/html
