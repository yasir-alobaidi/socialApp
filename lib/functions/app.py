from flask import Flask, request, jsonify
from sqlalchemy import create_engine
import pandas as pd
import nltk
from nltk.stem import WordNetLemmatizer
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
import json

app = Flask(__name__)

app.config['DEBUG'] = True

wish_id = ''
wisher_id = ''
wish_text = ''
date = ''
wish_privacy = ''
wish_status = ''
category = ''
giver_id = ''
announcement = ''
annID = ''
order = ''
search_text = ''


@app.route('/wish', methods=['GET', 'POST'])
def Route_name():
    global wish_id
    global wisher_id
    global wish_text
    global date
    global wish_privacy
    global wish_status
    global category
    global giver_id
    global announcement
    global annID
    global order

    if request.method == 'POST':
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        wish_id = request_data['wishId']

        # wisher_id =
        wisher_id = request_data['wisherId']

        # wishText =
        wish_text = request_data['wishText']

        # wishUploadDate =
        date = request_data['wishUploadDate']

        # wishPrivacy =
        wish_privacy = request_data['wishPrivacy']

        #  wishStatus =
        wish_status = request_data['wishStatus']

        # wishCategory =
        category = request_data['wishCategory']

        giver_id = request_data['GiverID']

        announcement = request_data['Announcement']

        annID = request_data['AnnouncementID']

        order = request_data['Order']

        return ' '
    else:
        return jsonify({
            'wishId': wish_id,
            'wisherId': wisher_id,
            'wishText': wish_text,
            'wishUploadDate': date,
            'wishPrivacy': wish_privacy,
            'wishStatus': wish_status,
            'wishCategory': category,
            'GiverID': giver_id,
            'Announcement': announcement,
            'AnnouncementID': annID,
            'Order': order

        })


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
                      columns=['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date', 'Category'])

    return wf


# games sorted wishes dataframe
def get_gs_frame():
    gsf_sql = pd.read_sql_table('games_sorted_wishes', my_conn)
    gsf = pd.DataFrame(gsf_sql, columns=['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date'])

    return gsf


# electronics sorted wishes dataframe
def get_es_frame():
    esf_sql = pd.read_sql_table('electronics_sorted_wishes', my_conn)
    esf = pd.DataFrame(esf_sql, columns=['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date'])

    return esf


# unsorted wishes dataframe
def get_unsorted_frame():
    unsorted_sql = pd.read_sql_table('unsorted_wishes', my_conn)
    unf = pd.DataFrame(unsorted_sql, columns=['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date'])

    return unf


def get_announcements_frame():
    annouc_sql = pd.read_sql_table('announcements',my_conn)    
    annc_frame = pd.DataFrame(annouc_sql,columns=['annID','name','username','annText','giverID','date'])

    return annc_frame


# filtering the wish from the bullying words
def filter_wish(wish):
    input_wish = str(wish).lower()
    token = nltk.word_tokenize(input_wish)
    wordnet_lemmatizer = WordNetLemmatizer()
    bf = get_bully_frame()
    vf = get_verbs_frame()
    filtered_sentence = []

    for w in token:
        w = wordnet_lemmatizer.lemmatize(w, pos="v")
        if w not in stop_words and w not in bf.values and w not in vf.values:
            filtered_sentence.append(w)

    filtered_sentence = [word for word in filtered_sentence if word.isalnum()]

    print(filtered_sentence)
    return filtered_sentence


def remove_bully_words(wish):
    token = word_tokenize(wish)
    filtered_sentence = []
    bf = get_bully_frame()

    for w in token:
        if w not in bf.values:
            filtered_sentence.append(w)
        else:
            filtered_sentence.append('*****')
    sent = " ".join(str(x) for x in filtered_sentence)
    return sent


# Wish Functions #

def sort_text(filtered_wish, frame, wish_id):
    gf = get_games_frame()
    ef = get_electronics_frame()
    unf = get_unsorted_frame()
    gsf = get_gs_frame()
    esf = get_es_frame()

    for w in filtered_wish:
        # insert into unsorted table
        if not gf['Gname'].str.contains(w).any() and not ef['productTitle'].str.contains(w).any():
            update_category("unsorted", wish_id)
            unf_new = unf.append(frame)
            unf_new.to_sql('unsorted_wishes', my_conn, if_exists='replace', index=False)
            break

        # check inside the electronics dataset
        elif ef['productTitle'].str.contains(w).any():
            update_category("Electronics", wish_id)
            esf_new = esf.append(frame)
            esf_new.to_sql('electronics_sorted_wishes', my_conn, if_exists='replace', index=False)
            break

        # check inside the video games dataset
        elif gf['Gname'].str.contains(w).any():
            update_category("Games", wish_id)
            gsf_new = gsf.append(frame)
            gsf_new.to_sql('games_sorted_wishes', my_conn, if_exists='replace', index=False)
            break


# insert into the wishes_list
def insert_wish(wisher_id, wish_text, wish_privacy, date):
    cleared_wish = remove_bully_words(wish_text)
    wishfr = pd.DataFrame(
        [{'WisherID': wisher_id, 'Wish_text': cleared_wish, 'wish_privacy': wish_privacy, 'date': date}])
    filtered_wish = filter_wish(wishfr['Wish_text'])
    wishfr.to_sql('wishes_list', my_conn, if_exists='append', index=False)
    wf = get_wishes_frame()
    sorting_frame = wf[['wishID', 'WisherID', 'Wish_text', 'wish_privacy', 'wish_status', 'date']].iloc[-1]
    wish_id = sorting_frame['wishID']

    # sort the wish into the corresponding table
    sort_text(filtered_wish, sorting_frame, wish_id)


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


def delete_wish(wish_id):
    try:
        pd.read_sql_query(f"DELETE from wishes_list where wishid = {wish_id};", my_conn)

    except Exception as e:
        print(e)


def delete_all_wishes(wisher_id):
    try:
        pd.read_sql_query(f"DELETE from wishes_list where wisherid = {wisher_id};", my_conn)

    except Exception as e:
        print(e)


def update_category(category, wID):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET Category = '{category}' WHERE wishID = '{wID}'", my_conn)

    except Exception as e:
        print(e)


def change_privacy(wish_id, wish_privacy):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET wish_privacy = '{wish_privacy}' where wishID = {wish_id} ;", my_conn)

    except Exception as e:
        print(e)


def change_to_fulfilled(wish_id):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET wish_status = 'fulfilled' where wishID = '{wish_id}' ;", my_conn)

    except Exception as e:
        print(e)


# Giver functions

def insert_ann(givID, announcement):
    cleared_ann = remove_bully_words(announcement)
    annframe = pd.DataFrame([{'annText': cleared_ann, 'giverID': givID}])
    annframe.to_sql('announcements', my_conn, if_exists='append', index=False)

    return 'announcement was posted successfully created'


def edit_ann(ann_id, new_ann):
    try:
        pd.read_sql_query(f"UPDATE announcements SET annText = '{new_ann}' where annID = {ann_id};", my_conn)

    except Exception as e:
        print(e)


def delete_ann(ann_id):
    try:
        pd.read_sql_query(f"DELETE from announcements where annID = {ann_id};", my_conn)

    except Exception as e:
        print(e)


# Sort wishes in wishes fees ascending
def sort_view(order):
    try:

        wf = get_wishes_frame()
        if order == 'ascending':
            sorted_frame = wf.sort_values(by=['date'], ascending=True)

        else:
            sorted_frame = wf.sort_values(by=['date'], ascending=False)

        print(sorted_frame)
        return sorted_frame

    except Exception as e:
        print(e)


def sort_view(order, category):
    try:

        wf = filter_wishes_feed(category)
        if order == 'ascending':
            sorted_frame = wf.sort_values(by=['date'], ascending=True)

        else:
            sorted_frame = wf.sort_values(by=['date'], ascending=False)

        print(sorted_frame)
        return sorted_frame

    except Exception as e:
        print(e)


def filter_wishes_feed(category):
    try:
        wf = get_wishes_frame()
        condition = wf['Category'] == category

        viewframe = wf.where(condition).dropna()

        print(viewframe)
        return viewframe

    except Exception as e:
        print(e)


def search_view(search_text):
    try:
        wf = get_wishes_frame()
        condition = wf['wish_text'].str.contains(search_text).any() & wf['wish_privacy'] == 'public'

        viewframe = wf.where(condition).dropna()

        print(viewframe)
        return viewframe
    except Exception as e:
        print(e)


# Views

# Wishers Views ###

# view wishes for wisher in the wishes feed
def view_public_wishes():
    try:
        wf = get_wishes_frame()
        condition = wf['wish_privacy'] == 'public'

        viewframe = wf.where(condition).dropna()

        print(viewframe)
    except Exception as e:
        print(e)


# view the wishes for the wisher account.
def view_my_wishes(wisher_id):
    try:
        wf = get_wishes_frame()
        condition = wf['WisherID'] == wisher_id

        viewframe = wf.where(condition).dropna()

        print(viewframe)
    except Exception as e:
        print(e)


# view the wishes for another account by a wisher
def view_account_wishes(wisher_id):
    try:
        wf = get_wishes_frame()
        condition = wf['wish_privacy'] == 'public' & wf['WisherID'] == wisher_id

        viewframe = wf.where(condition).dropna()

        print(viewframe)
    except Exception as e:
        print(e)


# Givers Views ###

# view wishes for giver in the wishes feed
def view_not_fulfilled():
    try:
        wf = get_wishes_frame()
        condition = wf['wish_status'] == 'not-fulfilled'

        viewframe = wf.where(condition).dropna()

        print(viewframe)
        return viewframe

    except Exception as e:
        print(e)


# view the wishes for another account by a giver
def giver_accounts_wishes(wisher_id):
    try:
        wf = get_wishes_frame()
        condition = (wf['wish_status'] == 'not-fulfilled') & (wf['WisherID'] == wisher_id)

        viewframe = wf.where(condition).dropna()

        print(viewframe)
    except Exception as e:
        print(e)


def request_method(req_num):
    # enter the parameters vvvvv ##
    switcher = {
        1: insert_wish(wisher_id, wish_text, wish_privacy, date),
        2: edit_wish(wish_id, wish_text),
        3: delete_wish(wish_id),
        4: delete_all_wishes(wisher_id),
        5: change_privacy(wish_id, wish_privacy),
        6: change_to_fulfilled(wish_id),
        7: insert_ann(giver_id, announcement),
        8: edit_ann(annID, announcement),
        9: delete_ann(annID),
        10: sort_view(order, category),
        11: filter_wishes_feed(category),
        12: search_view(search_text),
        13: view_public_wishes(),
        14: view_my_wishes(wisher_id),
        15: view_account_wishes(wisher_id),
        16: view_not_fulfilled(),
        17: giver_accounts_wishes(wisher_id)
    }
    return switcher.get(req_num, "no method is called")

    


# go home get ahead light speed internet i dont wanna talk ab dnwioqdn it was
# leave america, two kids follow her, i dont wanna talk ab whos doing it first?
# bara ba bam bam bam bam ba ram bam

# announcement = input("enter the text pls: ")
def view_annc():
    try:
        ann = get_announcements_frame()

       # viewframe = ann.where(condition).dropna()

        print(ann)
    except Exception as e:
        print(e)

view_annc()

delete_ann(3)

if __name__ == "__main__":
    app.run()
