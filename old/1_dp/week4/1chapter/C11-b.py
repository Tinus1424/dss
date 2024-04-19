with open("1_chapterfiles/pc_rose.txt", "r") as rf:
    with open("1_chapterfiles/pc_copy.txt", "w") as cf:
        count = 0
        while count < 100:
            line = rf.readline()
            if line == "":
                break
            cf.write(line + "\n")
            count += 1
