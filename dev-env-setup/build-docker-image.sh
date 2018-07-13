#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ] ; then
    echo "USASE:"
    echo "./build-docker-image.sh <EMAIL> <USERNAME>"
    exit
fi

docker build -t chasse-aux-bugs-env --build-arg email=${1} --build-arg username=${2} --no-cache .

