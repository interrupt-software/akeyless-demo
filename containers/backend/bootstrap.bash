#!/bin/bash
BASE=./
PYSOURCE=${BASE}/backend/listener.py
/usr/bin/python ${PYSOURCE} 2>&1 &
