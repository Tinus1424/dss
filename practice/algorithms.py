


# Exercise 3.1

a = [2, 4, 8, 7]
# Write a recursive sum function

def recsum(x):
    if len(x) == 1:
        return x[0]
    else:
        return x[0] + recsum(x[1:])


#print(recsum(a))

# Recursive count function

def reccount(x):
    i = 0
    if len(x) == 0:
        return i
    else:
        i += 1
        return i + reccount(x[1:])
    
#print(reccount(a))

def recmax(x):
    if len(x) == 2:
        return x[0] if x[0] > x[1] else x[1]
    sub_max = recmax(x[1:])        
    return x[0] if x[0] > sub_max else sub_max  
    

def recsearch(x, item):
    low = 0 
    high = 
    if len(x) == 1:
        return x[0]
    