# You can typecast a list 
t1 = ("apple", "banana", "cherry")
print(t1)
print(type(t1))
fruit_list = list(t1)
print(fruit_list)
print(type(fruit_list))

# useful for making an iterator into a list
numlist = range(1, 11)
print(numlist)
numlist = list(range(1, 11))
print(numlist)

# str into list
print(list("aaaaa"))

# immediately store functions that use yield
def add_one_to_all(X):
    for x in X:
        yield x + 1

print(list(add_one_to_all([1, 2, 3])))