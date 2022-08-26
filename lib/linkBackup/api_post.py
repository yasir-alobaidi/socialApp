#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json

response_wisherId = ''
response_wishText = ''
response_wishUploadDate = ''
response_wishPrivacy = ''

test = 'sht'



app = Flask(__name__)

@app.route('/wish', methods = ['GET','POST'])
def nameRoute():
    global response_wisherId
    global response_wishText
    global response_wishUploadDate
    global response_wishPrivacy


    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        wisherId =  request_data['wisherId']
        response_wisherId = wisherId

        wishText =  request_data['wishText']
        response_wishText = wishText

        wishUploadDate =  request_data['wishUploadDate']
        response_wishUploadDate = wishUploadDate

        wishPrivacy =  request_data['wishPrivacy']
        response_wishPrivacy = wishPrivacy

        print('before '+response_wisherId)
       # print(response_wishText)
       # print(response_wishUploadDate)
       # print(response_wishPrivacy)
        return printInfo()
    else:
        return jsonify({
            'wisherId' : response_wisherId,
            'wishText' : response_wishText,
            'wishUploadDate' : response_wishUploadDate,
            'wishPrivacy' : response_wishPrivacy
        })

print('after '+response_wisherId)

def printInfo():
    print(response_wisherId)
    print(response_wishText)
    print(response_wishUploadDate)
    print(response_wishPrivacy)

if __name__ == "__main__":
    app.run(debug=True)
