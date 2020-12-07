FROM nginx:stable-alpine

ADD ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

ADD ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html
