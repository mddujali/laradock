ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm-alpine

RUN apk update

RUN apk upgrade

RUN mkdir -p /scripts

ADD ./docker/php/libraries.sh /scripts

RUN chmod +x /scripts/libraries.sh

RUN /scripts/libraries.sh

WORKDIR /var/www/html
