import os
import sys
if sys.version_info[0] == 2:
    import ConfigParser as configparser
else:
    import configparser
import akeyless
from akeyless_client import dynamic_db_creds

dbcreds  = None
creds    = None
user     = None
password = None

try: 
  dbcreds = dynamic_db_creds()
except:
  print("Exception in reading dynamic secrets.")

if dbcreds is None:
    user     = os.environ["POSTGRES_USER"]
    password = os.environ["POSTGRES_PW"]
else:
    creds    = dynamic_db_creds()
    user     = creds["user"]
    password = creds["password"]

db_ini = {
    "host"     : os.environ["POSTGRES_ADDR"],
    "user"     : user,
    "password" : password,
    "dbname"   : os.environ["POSTGRES_DB"]
}

def dbconfig(params=db_ini):
    db = {}
    for param in params:
        db[param] = params[param]

    return db

# We are including a main module for demo purposes only
if __name__ == "__main__":
    print(dbconfig())
    