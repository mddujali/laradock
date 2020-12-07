#!/bin/bash

docker-compose down -v

sudo rm -rf ./docker/mysql/*

docker-compose up -d --build
