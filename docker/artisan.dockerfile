FROM php:7.4-fpm-alpine

ADD ./docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laradock && adduser -G laradock -g laradock -s /bin/sh -D laradock

RUN mkdir -p /var/www/html

RUN chown laradock:laradock /var/www/html

RUN set -xe && \
    apk add --no-cache --virtual .deps \
    $PHPIZE_DEPS \
    git \
    icu-libs \
    zlib \
    openssh \
    imagemagick \
    imagemagick-libs \
    imagemagick-dev \
    freetype \
    freetype-dev \
    libpng \
    libpng-dev  \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    libxslt \
    libxslt-dev \
    icu-dev \
    zlib-dev \
    libzip-dev \
    gmp-dev && \
    docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    intl \
    pdo \
    soap \
    pcntl \
    exif \
    gd \
    gmp \
    pdo_mysql \
    zip && \
    pecl install \
    imagick \
    redis && \
    docker-php-ext-enable --ini-name 20-imagick.ini imagick && \
    docker-php-ext-enable --ini-name 20-redis.ini redis

WORKDIR /var/www/html
