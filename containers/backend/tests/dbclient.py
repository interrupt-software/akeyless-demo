import psycopg2
import os
from dbconfig import config

class DBConn:
  def __init__(self):
    conn   = None
    cur    = None
    params = config()

  def connect():
    try:
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

  def get_user(name=None):
    cur = conn.cursor()

    table   = "customer"
    dbquery = "SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_NAME=\'%s\'" % (table)
    self.cur.execute(dbquery)
    headers = cur.fetchall()

    cols = []
    for col in headers:
        cols.append(col[0])

    name = "Linda"
    dbquery = "SELECT * FROM %s WHERE first_name=\'%s\'" % (table, name)
    cur.execute(dbquery)
    data = cur.fetchall()

    fields = []
    for field in data[0]:
        fields.append(field)

    sdata = { cols[i] : fields[i] for i in range(len(cols)) }

    return sdata
