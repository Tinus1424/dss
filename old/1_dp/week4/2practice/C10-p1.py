def replace_newline(text):
    text1 = text.replace("\n", " ")
    text1 = text.strip()
    return text1


reddit_post = "I've been pondering the effects of ambitious climate change policies\n\
on our economy and job market. \n\
While addressing environmental concerns is crucial,\n\
there's a lot of debate about the potential consequences for industries and employment."

print(replace_newline(reddit_post))

# THIS SOLUTION STILL PRINTS ON A NEW LINE??s