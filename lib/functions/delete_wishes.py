from imports import *

def delete_all_wishes(wisher_id):
    try:
        pd.read_sql_query(f"DELETE from wishes_list where wisherid = {wisher_id};", my_conn)

    except Exception as e:
        print(e)
