from imports import *
#from crypt import methods
from glob import glob
#from ssl import OP_NO_RENEGOTIATION
#from unicodedata import name
from flask import Flask, request, jsonify
import json, nltk

response_name = ''
response_username = ''
response_annText = ''
response_giverId = ''
response_annUploadDate = ''



app = Flask(__name__)

@app.route('/view_annc', methods = ['GET'])

# view the wishes for another account by a wisher
def view_annc():
    try:
        ann = get_announcements_frame()

        full_dict = {}
        for row in ann.iterrows():
            inner_dict = {}
            inner_dict["giverID"] = [row[1][1]]
            inner_dict["name"] = [row[1][2]]
            inner_dict["username"] = [row[1][3]]
            inner_dict["annText"] = [row[1][4]]
            inner_dict["date"] = [row[1][5]]
            
            full_dict[row[1][0]] = [inner_dict["giverID"], inner_dict["name"],inner_dict["username"],  inner_dict["annText"], inner_dict["date"]]
    
        jsonData = json.dumps(full_dict, indent= 1)
        print(jsonData)
        return jsonData
    except Exception as e:
        print(e)

view_annc()

if __name__ == "__main__":
    app.run(debug=True)