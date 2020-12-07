#!/bin/bash

.scripts/down.sh

rm -rf ./docker/volumes

.scripts/build-up.sh
