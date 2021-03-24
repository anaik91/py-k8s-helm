import os
from flask import Flask


app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello World!"


@app.route('/<name>')
def hello_name(name):
    return "Hello {}!".format(name)

@app.route('/healthz')
def healthz():
    return "OK"

if __name__ == '__main__':
    app.run()