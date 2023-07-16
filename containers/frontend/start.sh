#!/bin/bash
app="frontend"
MIDDLEWARE_ADDR=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" middleware)
docker build -t ${app} .
docker run -d -p 3000:80 \
  -e MIDDLEWARE_ADDR=${MIDDLEWARE_ADDR} \
  --name=${app} \
  -v $PWD:/app ${app}
