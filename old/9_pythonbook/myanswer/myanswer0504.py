import math

x = -1

while x < 4:
    i = math.exp(x) 
    print("The e of", x,"is {:.5f}".format(i))
    x += 1