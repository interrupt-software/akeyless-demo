#export POSTGRES_HOST="postgres_host"
#export POSTGRES_USER="postgres_user"
#export POSTGRES_PW="postgres_pw"
#export POSTGRES_DB="postgres_db"

export POSTGRES_HOST=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" postgres)
export POSTGRES_USER="postgres"
export POSTGRES_PW="mysecretpassword"
export POSTGRES_DB="dvdrental"
