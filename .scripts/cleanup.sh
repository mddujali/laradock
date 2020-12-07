#!/bin/bash

docker system prune -af
docker container prune -f
docker image prune -f
docker volume prune -f
docker network prune -f
docker builder prune -f

rm -rf ./docker/volumes
