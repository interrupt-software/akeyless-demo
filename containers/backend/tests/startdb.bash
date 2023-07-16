docker create volume dbdata

docker run -d \
  --name postgres \
  --mount type=bind,source=/home/vagrant/repos/python/database,target=/data \
  -e POSTGRES_PASSWORD=mysecretpassword \
  postgres
