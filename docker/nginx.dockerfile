FROM nginx:stable-alpine

ADD ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

ADD ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html

RUN addgroup -g 1000 laradock && adduser -G laradock -g laradock -s /bin/sh -D laradock

RUN chown laradock:laradock /var/www/html
