from imports import *

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


