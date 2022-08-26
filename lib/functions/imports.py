from flask import Flask, request, jsonify
from sqlalchemy import create_engine
import pandas as pd
import nltk
from nltk.stem import WordNetLemmatizer
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from glob import glob
import json

app = Flask(__name__)

app.config['DEBUG'] = True

# database connection
my_conn = create_engine("mysql+mysqldb://root:@localhost/wishwall")

# stop words to be detected from the text
stop_words = set(stopwords.words('english'))
stop_words = stop_words.union(['dtype', 'name', 'object', '0', 'new'])


# Datasets
# bullying table to dataframe
def get_bully_frame():
    bully_words = pd.read_sql_table('bullying', my_conn)
    bf = pd.DataFrame(bully_words, columns=['word'])

    return bf


# verbs table to dataframe
def get_verbs_frame():
    verb_words = pd.read_sql_table('verbs', my_conn)
    vf = pd.DataFrame(verb_words, columns=['verb'])

    return vf


# video-games table to dataframe
def get_games_frame():
    game_sql = pd.read_sql_table('video_games', my_conn)
    gf = pd.DataFrame(game_sql, columns=['Gname', 'Platform'])
    gf['Gname'] = gf['Gname'].str.lower()

    return gf


# electronics table to dataframe
def get_electronics_frame():
    elec_sql = pd.read_sql_table('electronics', my_conn)
    ef = pd.DataFrame(elec_sql, columns=['productTitle', 'categoryTitle'])
    ef['productTitle'] = ef['productTitle'].str.lower()

    return ef


# wishes table to dataframe
def get_wishes_frame():
    wishes_sql = pd.read_sql_table('wishes_list', my_conn)
    wf = pd.DataFrame(wishes_sql,
                      columns=['wishID', 'WisherID', "name","username", 'Wish_text', 'wish_privacy', 'wish_status', 'date', 'Category'])

    return wf


# games sorted wishes dataframe
def get_gs_frame():
    gsf_sql = pd.read_sql_table('games_sorted_wishes', my_conn)
    gsf = pd.DataFrame(gsf_sql, columns=['wishID', 'WisherID', 'name', 'username', 'Wish_text', 'wish_privacy', 'wish_status', 'date'])

    return gsf


# electronics sorted wishes dataframe
def get_es_frame():
    esf_sql = pd.read_sql_table('electronics_sorted_wishes', my_conn)
    esf = pd.DataFrame(esf_sql, columns=['wishID', 'WisherID', 'name', 'username','Wish_text', 'wish_privacy', 'wish_status', 'date'])

    return esf


# unsorted wishes dataframe
def get_unsorted_frame():
    unsorted_sql = pd.read_sql_table('unsorted_wishes', my_conn)
    unf = pd.DataFrame(unsorted_sql, columns=['wishID', 'WisherID','name', 'username', 'Wish_text', 'wish_privacy', 'wish_status', 'date'])

    return unf

def get_announcements_frame():
    annouc_sql = pd.read_sql_table('announcements',my_conn)    
    annc_frame = pd.DataFrame(annouc_sql,columns=['annID','name','username','annText','giverID','date'])

    return annc_frame