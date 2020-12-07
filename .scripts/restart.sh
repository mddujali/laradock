#!/bin/bash

.scripts/host.sh

docker-compose down

docker-compose up -d
