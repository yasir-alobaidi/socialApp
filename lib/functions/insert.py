from imports import *
from sorting import *
from filtering import *
from glob import glob
from flask import Flask, request, jsonify
import json


response_name = ''
response_username = ''
response_wisherId = ''
response_wishText = ''
response_wishUploadDate = ''
response_wishPrivacy = ''


app = Flask(__name__)

@app.route('/wish', methods = ['GET','POST'])
def nameRoute():

    global response_name
    global response_username
    global response_wisherId
    global response_wishText
    global response_wishUploadDate
    global response_wishPrivacy

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        wisherId =  request_data['wisherId']
        response_wisherId = wisherId

        name =  request_data['name']
        response_name = name

        username =  request_data['username']
        response_username = username

        wishText =  request_data['wishText']
        response_wishText = wishText

        wishUploadDate =  request_data['wishUploadDate']
        response_wishUploadDate = wishUploadDate

        wishPrivacy =  request_data['wishPrivacy']
        response_wishPrivacy = wishPrivacy


        return insert_wish(response_wisherId, response_name, response_username, response_wishText, response_wishPrivacy, response_wishUploadDate)
    else:
        return jsonify({
            'wisherId' : response_wisherId,
            'name': response_name,
            'username': response_username,
            'wishText' : response_wishText,
            'wishUploadDate' : response_wishUploadDate,
            'wishPrivacy' : response_wishPrivacy
        })

# insert into the wishes_list
def insert_wish(wisher_id, name, username, wish_text, wish_privacy, date):
    cleared_wish = remove_bully_words(wish_text)
    wishfr = pd.DataFrame(
        [{'WisherID': wisher_id, 'name': name, 'username': username, 'Wish_text': cleared_wish,
         'wish_privacy': wish_privacy, 'date': date}])
    filtered_wish = filter_wish(wishfr['Wish_text'])
    wishfr.to_sql('wishes_list', my_conn, if_exists='append', index=False)
    wf = get_wishes_frame()
    sorting_frame = wf[['wishID', 'WisherID', 'name', 'username', 'Wish_text', 'wish_privacy',
                         'wish_status', 'date']].iloc[-1]
    wish_id = sorting_frame['wishID']

    # sort the wish into the corresponding table
    sort_text(filtered_wish, sorting_frame, wish_id)


if __name__ == "__main__":
    app.run(debug=True)