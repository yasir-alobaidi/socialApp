from imports import *


def filter_wishes_feed(category):
    try:
        wf = get_wishes_frame()
        condition = wf['Category'] == category

        viewframe = wf.where(condition).dropna()

        print(viewframe)
        return viewframe

    except Exception as e:
        print(e)

