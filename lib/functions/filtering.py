from imports import *

# filtering the wish from the bullying words
def filter_wish(wish):
    input_wish = str(wish).lower()
    token = nltk.word_tokenize(input_wish)
    wordnet_lemmatizer = WordNetLemmatizer()
    bf = get_bully_frame()
    vf = get_verbs_frame()
    filtered_sentence = []

    for w in token:
        w = wordnet_lemmatizer.lemmatize(w, pos="v")
        if w not in stop_words and w not in bf.values and w not in vf.values:
            filtered_sentence.append(w)

    filtered_sentence = [word for word in filtered_sentence if word.isalnum()]

    print(filtered_sentence)
    return filtered_sentence


def remove_bully_words(wish):
    token = word_tokenize(wish)
    filtered_sentence = []
    bf = get_bully_frame()

    for w in token:
        if w not in bf.values:
            filtered_sentence.append(w)
        else:
            filtered_sentence.append('*****')
    sent = " ".join(str(x) for x in filtered_sentence)
    return sent
