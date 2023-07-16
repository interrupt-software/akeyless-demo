FROM python:2

ADD listener.py /
ADD dbclient.py /
ADD dbconfig.py /

RUN pip install pystrich
RUN pip install psycopg2

EXPOSE 20000

CMD [ "python", "listener.py" ]
