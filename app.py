import os
from flask import Flask,jsonify,request,redirect, url_for


app = Flask(__name__)
app.config['DUMP_LOCATION'] = os.getenv('DUMP_LOCATION')

@app.route('/')
def hello():
    return "Hello World!"

def write2file(file,data):
    with open(file,'w') as fl:
        fl.write(data)

@app.route('/fetch/<file>', methods = ['GET'])
def fetch(file):
    filename='{}/{}'.format(app.config.get('DUMP_LOCATION'),file)
    data = open(filename).read()
    return '''
            <div>
            <p name="data">{}</textarea>
            </div>
            '''.format(data)

@app.route('/dump', methods = ['GET', 'POST'])
def dump():
    if request.method == 'POST':
        file = request.form.get('file')
        data = request.form.get('data')
        filename='{}/{}'.format(app.config.get('DUMP_LOCATION'),file)
        write2file(filename,data)
        print(url_for('fetch',file=file))
        return redirect(url_for('fetch', file=file))
    return '''
            <form method="POST">
                <div><label>File Name: <input type="text" name="file"></label></div>
                <div>
                <textarea name="data" rows="4" cols="50">
                Enter Something..</textarea>
                </div>
                <input type="submit" value="Submit">
            </form>'''

@app.route('/healthz')
def healthz():
    return "OK"

if __name__ == '__main__':
    app.run()