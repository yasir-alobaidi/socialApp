from imports import *

def search_view(search_text):
    try:
        wf = get_wishes_frame()
        condition = wf['wish_text'].str.contains(search_text).any() & wf['wish_privacy'] == 'public'

        viewframe = wf.where(condition).dropna()

        print(viewframe)
        return viewframe
    except Exception as e:
        print(e)
