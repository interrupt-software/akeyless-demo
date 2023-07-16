import socket
import sys
import pickle
from dbclient import *

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = ('0.0.0.0', 20000)
print >>sys.stderr, 'Starting up on %s port %s' % server_address
sock.bind(server_address)

# Listen for incoming connections
sock.listen(1)

while True:
    # Wait for a connection
    print >>sys.stderr, 'Waiting for a connection on %s port %s' % server_address
    connection, client_address = sock.accept()

    try:
        print >>sys.stderr, 'connection from', client_address
        message = None
        data = None
        # Receive the data in small chunks and retransmit it
        while True:
            first_name = connection.recv(16)
            print >>sys.stderr, first_name

            if first_name:
                dbconn = DBConn()
                dbconn.connect()
                dbdata = dbconn.get_user(first_name)
                dbconn.close()

                print >> sys.stderr, dbdata
                message = pickle.dumps(dbdata)
                connection.sendall(message)
            else:
                break
        # print >>sys.stderr, message

    finally:
        # Clean up the connection
        connection.close()
