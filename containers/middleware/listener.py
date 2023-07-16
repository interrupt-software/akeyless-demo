import socket
import sys
import pickle
from backend import *

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = ('0.0.0.0', 10000)
print >>sys.stderr, 'starting up on %s port %s' % server_address
sock.bind(server_address)

# Listen for incoming connections
sock.listen(5)

while True:
    # Wait for a connection
    print >>sys.stderr, 'waiting for a connection'
    connection, client_address = sock.accept()

    try:
        print >>sys.stderr, 'connection from', client_address
        message = None
        # Receive the data in small chunks and retransmit it
        while True:
            data = connection.recv(16)
            print >>sys.stderr, data
            if data:
                message = connect(data)
                # It's already pickled from the backend
                message = pickle.loads(message)
                print >> sys.stderr, message
                message = pickle.dumps(message)
                connection.sendall(message)
            else:
                break

    finally:
        # Clean up the connection
        connection.close()
