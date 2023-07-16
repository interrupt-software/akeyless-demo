#!/usr/bin/python3

import socket
import ssl
import os

server_address = (os.environ['MIDDLEWARE_ADDR'], 10443)
server_sni_hostname = 'app1.dev.interrupt.com'
client_cert = 'client.crt'
client_key  = 'client.key'
client_certs = 'ca_bundle.crt'

def load_context():
    context = ssl.create_default_context(ssl.Purpose.SERVER_AUTH, cafile=client_certs)
    context.load_cert_chain(certfile=client_cert, keyfile=client_key)
    context.load_verify_locations(cafile=client_certs)
    return context

def conn():
    context = load_context()
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except (SSLError) as e:
        print("SSL exception. {}".format(e.args[-1]))

    conn = context.wrap_socket(s, server_side=False, server_hostname=server_sni_hostname)
    conn.connect(server_address)
    print(conn.getpeercert())
    print("Sending: 'Hello, world!")
    conn.send(b"Hello, world!")
    print("Closing connection")
    conn.close()
