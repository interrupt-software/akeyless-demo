#!/bin/bash
app="middleware"
BACKEND_ADDR=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" backend)
docker build -t ${app} .
docker run -d -p 10000:10000 \
  -e BACKEND_ADDR=${BACKEND_ADDR} \
  --name=${app} ${app}
