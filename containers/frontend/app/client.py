import socket
import sys
import os
import pickle
import datetime

def conn(first_name='John'):
  # Create a TCP/IP socket
  sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

  # Connect the socket to the port where the server is listening
  server_address = (os.environ['MIDDLEWARE_ADDR'], 10000)
  sock.connect(server_address)

  response = ""

  cols = []
  data = []

  try:

    # Receive database data
    # Send data
    request = first_name.encode()
    sock.sendall(request)

    # Look for the response
    response = sock.recv(1024)
    response = pickle.loads(response, encoding="bytes")

    for item in response:
      key = item.decode()
      val = ''

      if isinstance(response[item], bytes):
          val = response[item].decode()
      elif isinstance(response[item], datetime.date):
          val = response[item].strftime('%Y-%m-%d')
      elif isinstance(response[item], datetime.datetime):
          # 2013, 5, 26, 14, 49, 45, 738000
          val = response[item].strftime('%Y-%m-%d %H:%M%S')
      elif isinstance(response[item], bool) or isinstance(response[item], int):
          # 2013, 5, 26, 14, 49, 45, 738000
          val = str(response[item])
      else:
          val = response[item]

      cols.append(key)
      data.append(val)

  finally:
      sock.close()
      return cols, data
