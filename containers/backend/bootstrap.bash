#!/bin/bash
BASE=/home/vagrant
PYSOURCE=${BASE}/backend/listener.py
/usr/bin/python ${PYSOURCE} 2>&1 &
