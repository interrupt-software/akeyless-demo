#!/bin/bash
app="backend"
POSTGRES_HOST=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" postgres)
POSTGRES_DB="postgres"
AKEYLESS_ACCESS_ID="foo"
AKEYLESS_ACCESS_KEY="bar"
AKEYLESS_HOST=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" akeyless-gateway)

docker build -t ${app} .
docker run -d \
  -e POSTGRES_ADDR=${POSTGRES_HOST} \
  -e POSTGRES_DB=${POSTGRES_DB} \
  -e AKEYLESS_ACCESS_ID=${AKEYLESS_ACCESS_ID} \
  -e AKEYLESS_ACCESS_KEY=${AKEYLESS_ACCESS_KEY} \
  -e AKEYLESS_HOST="http://${AKEYLESS_ACCESS_KEY}" \
  --name=${app} ${app}
