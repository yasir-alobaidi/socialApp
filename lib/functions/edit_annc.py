from imports import *

def edit_ann(ann_id, new_ann):
    try:
        pd.read_sql_query(f"UPDATE announcements SET annText = '{new_ann}' where annID = {ann_id};", my_conn)

    except Exception as e:
        print(e)
