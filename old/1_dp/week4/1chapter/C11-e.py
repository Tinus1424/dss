import os
from os.path import join, getsize
def getdirsize(directory):
    filelist = os.listdir(directory)
    size = 0
    for file in filelist:
        print(file)
        pathname = join(directory, file)
        size += getsize(pathname)
        print(size)
    return size

gsize = getdirsize("9_pcdata") 
print(gsize)