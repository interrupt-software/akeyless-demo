FROM python:2

ADD listener.py /
ADD backend.py /

RUN pip install pystrich

EXPOSE 10000

CMD [ "python", "listener.py" ]
