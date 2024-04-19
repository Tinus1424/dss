def analyze_followers(follower_counts, target):
    copyfollowers = follower_counts[:]
    notin = []
    while True:
        try: 
            element = copyfollowers.pop()
        except IndexError:
            break
        if element < 80:
            notin.insert(0, element)
            continue
    return False, notin


follower_data = [8, 67, 160, 32, 421, 79, 215]
follower_target = 80
print(analyze_followers(follower_data, follower_target))