#!/bin/bash
BASE=./
FLASK_APP=frontend.py
cd ${BASE}/app
python3 -m venv venv
source venv/bin/activate
export FLASK_APP
nohup flask run --host=0.0.0.0 &
