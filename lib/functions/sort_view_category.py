from imports import *
from filter_feed import *


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
