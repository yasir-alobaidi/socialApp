from imports import *

def view_public_wishes():
    try:
        wf = get_wishes_frame()
        condition = wf['wish_privacy'] == 'public'

        viewframe = wf.where(condition).dropna()

        print(viewframe)
    except Exception as e:
        print(e)

