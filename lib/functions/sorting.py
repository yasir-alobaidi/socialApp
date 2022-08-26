from imports import *


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


def update_category(category, wID):
    try:
        pd.read_sql_query(f"UPDATE wishes_list SET Category = '{category}' WHERE wishID = '{wID}'", my_conn)

    except Exception as e:
        print(e)
