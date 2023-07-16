from flask import render_template, flash, request
from flask_wtf import Form
from wtforms import TextField, TextAreaField, validators, StringField, SubmitField
from app import app
from app import client
from app import ssl_client
# from app import hvac_client

@app.route('/')
@app.route('/index')
def index():
    return render_template('home.html')

@app.route('/ssl.html')
def ssl():
    try:
        ssl_client.conn()
    finally:
        return render_template('ssl.html')

@app.route('/hvac.html')
def hvac():
    try:
        ssl_client.conn()
    finally:
        return render_template('hvac.html')


@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('404.html'), 404

class ReusableForm(Form):
    name = TextField('Name:', validators=[validators.required()])

    @app.route("/query", methods=['GET', 'POST'])

    def query():
        form = ReusableForm(request.form)
        if request.method == 'POST' and form.validate():
            name=request.form['name']

            cols, data = client.conn(name)

            print(cols, data)

            if(len(data)==0):
                flash('This customer does not exist. ')
                return render_template('query.html', form=form)
            else:
                return render_template('template.html', cols=cols, data=data)

        else:
            # flash(form.errors)
            flash('All the form fields are required. ')

        return render_template('query.html', form=form)
