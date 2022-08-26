from imports import *
from sorting import *
from filtering import *
#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json, nltk

response_wishId = ''
response_wisherId = ''
response_wishText = ''
response_wishUploadDate = ''
response_wishPrivacy = ''

app = Flask(__name__)

@app.route('/wisherid', methods = ['GET','POST'])
def nameRoute():

    global response_wisherId

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        wisherId =  request_data['wisherId']
        response_wisherId = wisherId

        #print(response_wisherId)
        return response_wisherId
    else:
        return jsonify({
            'wisherId' : response_wisherId,
            })