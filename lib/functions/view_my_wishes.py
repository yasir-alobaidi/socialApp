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

        print(response_wisherId)
        return response_wisherId
    else:
        return jsonify({
            'wisherId' : response_wisherId,
            })


@app.route('/own_view', methods = ['GET'])
# view the wishes for another account by a wisher
def view_my_wishes():
    try:
        wf = get_wishes_frame()
        condition = wf['WisherID'] == response_wisherId
        viewframe = wf.where(condition).dropna()

        full_dict = {}
        for row in viewframe.iterrows():
            inner_dict = {}
            inner_dict["wishID"] = [row[1][0]]
            inner_dict["WisherID"] = [row[1][1]]
            inner_dict["name"] = [row[1][2]]
            inner_dict["username"] = [row[1][3]]
            inner_dict["Wish_text"] = [row[1][4]]
            inner_dict["wish_privacy"] = [row[1][5]]
            inner_dict["wish_status"] = [row[1][6]]
            inner_dict["date"] = [row[1][7]]
            inner_dict["Category"] = [row[1][8]]
            
            full_dict[row[1][0]] = [inner_dict["wishID"],inner_dict["WisherID"], inner_dict["name"],inner_dict["username"],  inner_dict["Wish_text"], inner_dict["wish_privacy"], inner_dict["wish_status"], inner_dict["date"], inner_dict["Category"]]
            
        jsonData = json.dumps(full_dict, indent= 1)
        print(jsonData) 

        return jsonData
    except Exception as e:
        print(e)

view_my_wishes()

if __name__ == "__main__":
    app.run(debug=True)