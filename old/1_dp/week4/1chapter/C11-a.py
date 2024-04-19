with open("1_chapterfiles/pc_writetest.tmp", "w") as fp:
    counter = 0
    while counter < 10:
        counter += 1
        text = "line\n" + str(counter)
        fp.write(text)

with open("1_chapterfiles/pc_writetest.tmp") as fp:
    in_buffer = fp.read()

print(in_buffer)