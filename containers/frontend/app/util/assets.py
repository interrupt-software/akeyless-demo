from flask_assets import Bundle, Environment
from .. import app

bundles = {

    'admin_js': Bundle(
        '/static/js/jquery.min.js',
        '/static/js/breakpoints.min.js',
        '/static/js/util.js',
        '/static/js/browser.min.js',
        '/static/js/main.js'
        ),

    'admin_css': Bundle(
        '/static/css/style.css',
        '/static/css/font-awesome.min.css'
        )
}
