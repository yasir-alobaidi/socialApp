from imports import *
from sorting import *
from filtering import *
#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json, nltk


@app.route('/deleteann', methods = ['GET','POST'])
def nameRoute():

    global response_annId

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        annId =  request_data['annId']
        response_annId = annId

        return delete_ann(response_annId) 
    else:
        return jsonify({
            'annId' : response_annId,
            })

def delete_ann(ann_id):
    try:
        pd.read_sql_query(f"DELETE from announcements where annID = {ann_id};", my_conn)

    except Exception as e:
        print(e)

if __name__ == "__main__":
    app.run(debug=True)