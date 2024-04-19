#Exercise 9.1
def getMultiplication(x):
    for i in range(1,11):
        print("{} * {} = {}".format(i,x,i*x))

getMultiplication(12)

#Exercise 9.2
def getCommonChar(string1, string2):
    common = ""
    for letter in string1:
        if letter in string2 and letter not in common:
            common += letter
    return(len(common))

#Exercise 9.3
from random import random

print(int(random()*10))