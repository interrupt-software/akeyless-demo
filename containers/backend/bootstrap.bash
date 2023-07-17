#!/bin/bash
BASE=$PWD/..
PYSOURCE=${BASE}/backend/listener.py
/usr/bin/python ${PYSOURCE} 2>&1 &
