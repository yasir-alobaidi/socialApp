#from crypt import methods
from glob import glob
#from unicodedata import name
from flask import Flask, request, jsonify
import json

response_giverId = ''
response_annText = ''
response_annUploadDate = ''

app = Flask(__name__)

@app.route('/ann', methods = ['GET','POST'])
def nameRoute():
    global response_giverId
    global response_annText
    global response_annUploadDate

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        giverId =  request_data['giverId']
        response_giverId = giverId

        annText =  request_data['annText']
        response_annText = annText

        annUploadDate =  request_data['annUploadDate']
        response_annUploadDate = annUploadDate

        return ' '
    else:
        return jsonify({
            'giverId' : response_giverId,
            'annText' : response_annText,
            'annUploadDate' : response_annUploadDate
        })

if __name__ == "__main__":
    app.run(debug=True)