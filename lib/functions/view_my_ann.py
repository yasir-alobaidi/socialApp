from imports import *
from sorting import *
from filtering import *
#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json, nltk

response_annId = ''
response_giverId = ''
response_annText = ''
response_annUploadDate = ''

app = Flask(__name__)

@app.route('/giverid', methods = ['GET','POST'])
def nameRoute():

    global response_giverId

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        giverId =  request_data['giverId']
        response_giverId = giverId

        print(response_giverId)
        return response_giverId
    else:
        return jsonify({
            'giverId' : response_giverId,
            })


@app.route('/own_view', methods = ['GET'])
# view the wishes for another account by a wisher
def view_my_ann():
    try:
        wf = get_announcements_frame()
        #condition = wf['wish_privacy'] == 'public' & wf['WisherID'] == wisher_id
        condition = wf['giverID'] == response_giverId
        viewframe = wf.where(condition).dropna()

        print(viewframe)

        full_dict = {}
        for row in viewframe.iterrows():
            inner_dict = {}
            inner_dict["annID"] = [row[1][0]]
            inner_dict["name"] = [row[1][1]]
            inner_dict["username"] = [row[1][2]]
            inner_dict["annText"] = [row[1][3]]
            inner_dict["giverID"] = [row[1][4]]
            inner_dict["date"] = [row[1][5]]
            
            full_dict[row[1][0]] = [inner_dict["annID"],inner_dict["name"], inner_dict["username"],inner_dict["username"],  inner_dict["annText"], inner_dict["giverID"], inner_dict["date"],]
            
        jsonData = json.dumps(full_dict, indent= 1)
        print(jsonData) 

        return jsonData
    except Exception as e:
        print(e)

view_my_ann()

@app.route('/edit_ann', methods = ['GET','POST'])
def nameRouteEdit():

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        annId =  request_data['annId']
        response_annId = annId

        newAnn =  request_data['annText']
        response_annText = newAnn

        print(response_annId)
        print(response_annText)
        Data = edit_ann(response_annId, response_annText)
        print(Data)
        return Data
    else:
        return "Get is not the right choice"


def edit_ann(ann_id, new_ann):
    try:
        change_ann(ann_id, new_ann)

        wf = get_announcements_frame()
        condition = wf['annID'] == ann_id
        edited_frame = wf[['annID','name','username', 'annText', 'giverID', 'date']].where(
            condition).dropna()
        print(edited_frame)

        filtered_wish = filter_wish(edited_frame['annText'])
        inserted_frame = edited_frame[['annID', 'name', 'username', 'annText', 'giverID', 'date']]
        sort_text(filtered_wish, inserted_frame, ann_id)

    except Exception as e:
        print(e)

def change_ann(ann_id, new_ann):
    try:
        pd.read_sql_query(f"UPDATE announcements SET annText = '{new_ann}' where annID = {ann_id};", my_conn)

    except Exception as e:
        print(e)



if __name__ == "__main__":
    app.run(debug=True)