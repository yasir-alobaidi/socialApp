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

@app.route('/edit_wish', methods = ['GET','POST'])
def nameRouteEdit():

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        wishId =  request_data['wishId']
        response_wishId = wishId

        newWish =  request_data['wishText']
        response_wishText = newWish

        Data = edit_wish(response_wishId,response_wishText)
        return Data
    else:
        return "Get is not the right choice"


def edit_wish(wish_id, new_wish):
    try:
        change_wish(wish_id, new_wish)

        wf = get_wishes_frame()
        condition = wf['wishID'] == wish_id
        edited_frame = wf[['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date', 'Category']].where(
            condition).dropna()
        print(edited_frame)

        filtered_wish = filter_wish(edited_frame['Wish_text'])
        inserted_frame = edited_frame[['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date']]
        sort_text(filtered_wish, inserted_frame, wish_id)

    except Exception as e:
        print(e)


def change_wish(wish_id, new_wish):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET Wish_text = '{new_wish}' where wishid = {wish_id};", my_conn)

    except Exception as e:
        print(e)

if __name__ == "__main__":
    app.run(debug=True)