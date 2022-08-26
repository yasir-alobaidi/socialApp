from imports import *
from sorting import *
from filtering import *
#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json, nltk


@app.route('/deletewish', methods = ['GET','POST'])
def nameRoute():

    global response_wishId

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        wishId =  request_data['wishId']
        response_wishId = wishId

        print(response_wishId)
        return delete_wish(response_wishId) 
    else:
        return jsonify({
            'wishId' : response_wishId,
            })


def delete_wish(wish_id):
    try:
        pd.read_sql_query(f"DELETE from wishes_list where wishid = {wish_id};", my_conn)

    except Exception as e:
        print(e)

if __name__ == "__main__":
    app.run(debug=True)