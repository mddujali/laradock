FROM composer:latest

RUN addgroup -g 1000 laradock && adduser -G laradock -g laradock -s /bin/sh -D laradock

WORKDIR /var/www/html
