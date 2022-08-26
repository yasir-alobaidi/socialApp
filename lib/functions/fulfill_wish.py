from imports import *

def change_to_fulfilled(wish_id):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET wish_status = 'fulfilled' where wishID = '{wish_id}' ;", my_conn)

    except Exception as e:
        print(e)

