def bottle_song(bottles):
    string = ("")
    while bottles > 0:
        bottles -= 1
        add =  str(bottles) + " bottles of beer on the wall, "
        add2 = str(bottles) + " of beer. "
        string += add + add2
    return string
        

bot = bottle_song(10)
print(bot)