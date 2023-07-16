import socket
import sys
import os

def connect(first_name='John'):
  # Create a TCP/IP socket
  sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

  # Connect the socket to the port where the server is listening
  server_address = (os.environ['BACKEND_ADDR'], 20000)
  sock.connect(server_address)

  response = ""

  try:

    # Receive database data
    # Send data
    request = first_name.encode()
    sock.sendall(request)

    # Look for the response
    response = sock.recv(1024)

  finally:
      sock.close()
      return response
