def comm(string1, string2):
    i = 0
    string3 = ("")
    for x in string1:
        if x in string3:
            continue
        elif x in string2:
            string3 += x
        continue
    return len(string3)

yo = comm("beeB", "peebbbbbbBr")
print(yo)