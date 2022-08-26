from imports import *
from filtering import *

#from crypt import methods
from glob import glob
#from unicodedata import name
from flask import Flask, request, jsonify
import json

response_giverId = ''
response_annText = ''
response_annUploadDate = ''
response_name = ''
response_username = ''

app = Flask(__name__)

@app.route('/ann', methods = ['GET','POST'])
def nameRoute():
    global response_giverId
    global response_annText
    global response_name
    global response_username

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        giverId =  request_data['giverId']
        response_giverId = giverId

        name =  request_data['name']
        response_name = name

        username =  request_data['username']
        response_username = username

        annText =  request_data['annText']
        response_annText = annText

        annUploadDate =  request_data['annUploadDate']
        response_annUploadDate = annUploadDate

        

        return insert_ann(response_giverId, response_annText, response_annUploadDate)
    else:
        return jsonify({
            'giverId' : response_giverId,
            'name': response_name,
            'username': response_username,
            'annText' : response_annText,
            'annUploadDate' : response_annUploadDate
        })


def insert_ann(givID, name, username, announcement, date):
    cleared_ann = remove_bully_words(announcement)
    annframe = pd.DataFrame([{'annText': cleared_ann, 'giverID': givID, 'name': name, 'username': username, 'date': date}])
    annframe.to_sql('announcements', my_conn, if_exists='append', index=False)
    return 'announcement was posted successfully created'

if __name__ == "__main__":
    app.run(debug=True)












