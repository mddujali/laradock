FROM php:7.4-fpm-alpine

ADD ./docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laradock && adduser -G laradock -g laradock -s /bin/sh -D laradock

RUN mkdir -p /var/www/html

RUN chown laradock:laradock /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

RUN apk update

RUN apk upgrade

ARG XDEBUG_VERSION

ARG XDEBUG_IDEKEY

ARG XDEBUG_REMOTE_HOST

ARG XDEBUG_REMOTE_PORT

RUN apk --no-cache add --virtual .build-deps \
    g++ \
    autoconf \
    make && \
    pecl install xdebug-$XDEBUG_VERSION && \
    docker-php-ext-enable xdebug && \
    apk del .build-deps && \
    rm -r /tmp/pear/* && \
    echo -e "xdebug.remote_enable=1\n\
        xdebug.remote_autostart=1\n\
        xdebug.remote_connect_back=0\n\
        xdebug.mode=debug\n\
        xdebug.remote_log=/var/www/html/storage/logs/xdebug.log\n\
        xdebug.idekey=\"$XDEBUG_IDEKEY\"\n\
        xdebug.client_host=$XDEBUG_REMOTE_HOST\n\
        xdebug.remote_port=$XDEBUG_REMOTE_PORT" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /var/www/html
