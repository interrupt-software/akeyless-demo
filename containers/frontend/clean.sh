#!/bin/bash
app="front-end"
docker stop ${app}
docker rm ${app}
docker rmi ${app}

