import psycopg2
import os
from dbconfig import dbconfig

class DBConn:
  def __init__(self):
    self.conn   = None
    self.cur    = None
    self.params = dbconfig()

  def connect(self):
    try:
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        self.conn = psycopg2.connect(**self.params)

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        return

  def get_user(self, first_name='John'):

    self.cur = self.conn.cursor()
    table    = "customer"

    dbquery  = "SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_NAME=\'%s\'" % (table)
    self.cur.execute(dbquery)
    headers  = self.cur.fetchall()

    cols = []
    for col in headers:
        cols.append(col[0])

    dbquery = "SELECT * FROM %s WHERE first_name=\'%s\'" % (table, first_name)
    self.cur.execute(dbquery)
    data = self.cur.fetchall()
    
    print data, len(data)

    fields = []

    if len(data) > 0:
        for field in data[0]:
            fields.append(field)
    
    sdata = {}

    if len(fields) == len(cols):
        sdata = { cols[i] : fields[i] for i in range(len(cols)) }
    else:
        sdata = { cols[i] : "-" for i in range(len(cols)) }

    return sdata

  def close(self):
    if self.cur is not None:
        self.cur.close()
    if self.conn is not None:
        self.conn.close()
