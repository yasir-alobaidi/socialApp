from imports import *

def change_privacy(wish_id, wish_privacy):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET wish_privacy = '{wish_privacy}' where wishID = {wish_id} ;", my_conn)

    except Exception as e:
        print(e)
