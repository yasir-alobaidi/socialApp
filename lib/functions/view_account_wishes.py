from imports import *
#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json, nltk

response_wisherId = ''
response_wishText = ''
response_wishUploadDate = ''
response_wishPrivacy = ''

app = Flask(__name__)

@app.route('/public_view', methods = ['GET'])

# view the wishes for another account by a wisher
def view_account_wishes():
    try:
        wf = get_wishes_frame()
        condition = wf['wish_privacy'] == 'public' 
        viewframe = wf.where(condition).dropna()

        print(viewframe)

        full_dict = {}
        for row in viewframe.iterrows():
            inner_dict = {}
            inner_dict["WisherID"] = [row[1][1]]
            inner_dict["name"] = [row[1][2]]
            inner_dict["username"] = [row[1][3]]
            inner_dict["Wish_text"] = [row[1][4]]
            inner_dict["wish_privacy"] = [row[1][5]]
            inner_dict["wish_status"] = [row[1][6]]
            inner_dict["date"] = [row[1][7]]
            inner_dict["Category"] = [row[1][8]]
            
            full_dict[row[1][0]] = [inner_dict["WisherID"], inner_dict["name"],inner_dict["username"],  inner_dict["Wish_text"], inner_dict["wish_privacy"], inner_dict["wish_status"], inner_dict["date"], inner_dict["Category"]]
        
        jsonData = json.dumps(full_dict, indent= 1)
        print(jsonData) 
        return jsonData
    except Exception as e:
        print(e)

view_account_wishes()

if __name__ == "__main__":
    app.run(debug=True)
