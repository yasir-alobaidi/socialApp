from imports import *

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

