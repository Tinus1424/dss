def average_review_wordcount(reviews):
    sumwordcount = 0
    for x in reviews:
        words = x.split()
        sumwordcount += len(words)
    return round(sumwordcount / len(reviews)) 

reviews = ("The product is amazing! I love it.",
    "Not satisfied with the quality. Needs improvement.",
    "Fast delivery and excellent customer service.")
print(average_review_wordcount(reviews))