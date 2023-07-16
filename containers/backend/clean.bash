#!/bin/bash
app="backend"
docker stop ${app}
docker rm ${app}
docker rmi ${app}
