#!/bin/bash

IP_ADDRESS=$(ip addr show | grep "\binet\b.*\bdocker0\b" | awk '{print $2}' | cut -d '/' -f 1)
HOST="host.docker.internal"

if grep -q "$HOST" /etc/hosts
    then
        sudo sed -i "/$HOST/ s/.*/$IP_ADDRESS\t$HOST/g" /etc/hosts
    else
        echo -e "$IP_ADDRESS\t$HOST" | sudo tee -a /etc/hosts &> /dev/null
fi
