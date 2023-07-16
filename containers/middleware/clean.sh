#!/bin/bash
app="middleware"
docker stop ${app}
docker rm ${app}
docker rmi ${app}

