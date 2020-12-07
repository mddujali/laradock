# LaraDock

A simple boilerplate for Laravel project with Docker.

## Getting Started

- Copy `.env.example` to `.env`
- Change `/path/to/project` into project path in your machine for `PROJECT_PATH`
- Change `project` into project name for `DOCKER_CONTAINER_BASE_NAME`
- Specify other environment variables
- Copy `docker-compose.yml.example` to `docker-compose.yml`
- Copy `docker-compose.override.yml.example` to `docker-compose.override.yml` to override default config

## Running Commands

- Run `docker-compose run --rm php` to execute php commands, example `docker-compose run --rm php ./vendor/bin/phpunit`
- Run `docker-compose run --rm composer` to execute composer commands, exmaple `docker-compose run --rm composer install`
- Run `docker-compose run --rm npm` to execute npm commands, example `docker-compose run --rm npm install`
- Run `docker-compose run --rm artisan` to execute artisan commands, example `docker-compose run --rm artisan migrate` to execute outstanding migrations
