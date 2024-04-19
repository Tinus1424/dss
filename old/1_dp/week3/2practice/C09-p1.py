def analyze_likes(post_likes):
    total = 0
    average = 0
    i = 0
    maxi = max(post_likes)
    for x in post_likes:
        i += 1
        total += x
        average = total / i
    return total, maxi, average


post_likes = (13, 555, 9883, 7)
print(analyze_likes(post_likes))

