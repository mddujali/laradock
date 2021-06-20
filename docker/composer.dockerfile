ARG COMPOSER_VERSION

FROM composer:${COMPOSER_VERSION}

RUN addgroup -g 1000 laradock && adduser -G laradock -g laradock -s /bin/sh -D laradock

RUN mkdir -p /var/www/html

RUN chown laradock:laradock /var/www/html

WORKDIR /var/www/html
