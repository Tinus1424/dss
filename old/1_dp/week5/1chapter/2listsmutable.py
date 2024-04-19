# Lists are mutable in contrast to the collection

# Here are examples of how to make lists 
a_list = [1, 2, 3]
a_tuple = (1, 2, 3)
empty_list = list()
empty_tuple = tuple()
another_empty_list = []
another_empty_tuple = ()

a_list[1] = 700 #this works
print("I JUST SWAPPED INDEX 1 WITH 700", a_list)

# a_tuple[1] = 700 #and this results in a type error
# tuple's immutability makes them safe 

a_list[1:1] = [13]
print("I JUST INSERTED 13 BY ASSIGNING IT TO A ZERO-SIZED SLICE!", a_list)

a_list[0:1] = []
print("I JUST REMOVED INDEX 0!", a_list)

#TASK 
fruit_list = ["apple", "banana", "cherry", "durian", "orange"]

i = 0
insert = ""
while i < len(fruit_list):
    insert += fruit_list[i].upper() + " "
    i += 1
print(insert)