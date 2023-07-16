from flask import Flask
from flask_wtf import CSRFProtect
from flask_assets import Bundle, Environment

DEBUG = True

csrf = CSRFProtect()

app = Flask(__name__)
app.config.from_object(__name__)
app.config['SECRET_KEY'] = '7d441f27d441f27567d441f2b6176a'
csrf.init_app(app)

from app import routes
from .util import assets

assets = Environment(app)
