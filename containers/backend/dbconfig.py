import os
import sys
if sys.version_info[0] == 2:
    import ConfigParser as configparser
else:
    import configparser

dbcreds  = None
creds    = None
user     = None
password = None

dbcreds_source = 'dbcreds'

if os.path.isfile(dbcreds_source):
    dbcreds  = open(dbcreds_source, 'r')

if dbcreds is not None:
    creds    = dbcreds.readlines()
    user     = creds[0] or os.environ["POSTGRES_USER"]
    password = creds[1] or os.environ["POSTGRES_PW"]
else:
    user     = os.environ["POSTGRES_USER"]
    password = os.environ["POSTGRES_PW"]

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
