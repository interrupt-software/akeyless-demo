#!/bin/bash
app="backend"
POSTGRES_HOST=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" postgres)
POSTGRES_USER="postgres"
POSTGRES_PW="mysecretpassword"
POSTGRES_DB="postgres"

docker build -t ${app} .
docker run -d \
  -e POSTGRES_ADDR=${POSTGRES_HOST} \
  -e POSTGRES_USER=${POSTGRES_USER} \
  -e POSTGRES_PW=${POSTGRES_PW} \
  -e POSTGRES_DB=${POSTGRES_DB} \
  --name=${app} ${app}
