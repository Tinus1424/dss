def simindice(s1, s2):
    for c1 in range(0, len(s1)):
        if len(s2) == c1:
            break
        if s1[c1] == s2[c1]:
            print(c1, s1[c1])

# Similar characters at similar indices.
s1 = "The Holy Grail"
s2 = "Life of Brian"
simindice(s1, s2)