#!/bin/bash
BASE=/home/vagrant
PYSOURCE=${BASE}/middleware/listener.py
/usr/bin/python ${PYSOURCE} 2>&1 &
