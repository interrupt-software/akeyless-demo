#!/bin/bash
BASE=./
PYSOURCE=${BASE}/middleware/listener.py
/usr/bin/python ${PYSOURCE} 2>&1 &
