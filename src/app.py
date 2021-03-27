"""
Sample Wiki App using Flask
"""
import os
from flask import Flask,request,redirect, url_for


app = Flask(__name__)
app.config['DUMP_LOCATION'] = os.getenv('DUMP_LOCATION')

@app.route('/')
def hello():
    """
    Default Index
    """
    return "Hello World! v2"

def write2file(file,data):
    """
    Function to write to file
    """
    with open(file,'w') as filehandler:
        filehandler.write(data)

@app.route('/fetch/<file>', methods = ['GET'])
def fetch(file):
    """
    Route to Render files from DUMP_LOCATION
    """
    filename='{}/{}'.format(app.config.get('DUMP_LOCATION'),file)
    data = open(filename).read()
    return '''
            <div>
            <p name="data">{}</textarea>
            </div>
            '''.format(data)

@app.route('/dump', methods = ['GET', 'POST'])
def dump():
    """
    Route to Dump files from DUMP_LOCATION
    """
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
    """
    Route for Health Check
    """
    return "OK"

if __name__ == '__main__':
    app.run()
