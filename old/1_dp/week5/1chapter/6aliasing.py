# When deriving a list from another list, they both point to the same
#thing in memory, thus altering one alters the other

fruit_list = ["apple", "banana", "cherry", "durian"]
new_fruit_list = fruit_list
print(fruit_list)
print(new_fruit_list)
new_fruit_list[2] = "orange"
print(fruit_list)
print(new_fruit_list)

# You can check this because every variable has an id, and these
#ids are the same 
fruit_list = ["apple", "banana", "cherry", "durian"]
new_fruit_list = fruit_list
print(id(fruit_list))
print(id(new_fruit_list))

# If you want to make a copy, do the following
# This works because slices [:] are always extracted from the object
# and create a new object in memory

x = [1, 2, 3]
z = x[:2]
print(id(x), id(z))

# The keywords 'is' can be used to compare identities
fruit_list = ["apple", "banana", "cherry", "durian"]
new_fruit_list = fruit_list
very_new_fruit_list = fruit_list[:]

print(fruit_list is new_fruit_list)
print(fruit_list is very_new_fruit_list)

# The == operator compares the contents so that will return True
# for both statements in the case of lists
print(fruit_list == new_fruit_list)
print(fruit_list == very_new_fruit_list)

# SHALLOW COPIES
numlist = [1, 2, [3, 4]]
copylist = numlist[:]

numlist[0] = 5 # copylist is a copy of numlist so this does not 
# have an effect on copylist
numlist[2][0] = 6 # but the list inside numlist is not copied and
# refers to the actual list in copylist, thus this affects copylist
# as well
# the nested list is stored in copylist as an alias
print(numlist)
print(copylist)

# to avoid this porblem the deepcopy() functions allows you to make
# a copy of the entire list with nested lists and other mutable data structures

from copy import deepcopy

numlist = [1, 2, [3, 4]]
copylist = deepcopy(numlist)

numlist[0] = 5
numlist[2][0] = 6
print(numlist)
print(copylist)

# Lists passed to function as argument will provide the function
# with access to the alias of the list, thus the function can actually
# change the list

# FUNCTIONS CHANGE LISTS
def changelist(x):
    if len(x) > 0:
        x[0] = "CHANGE!"
        
fruit_list = ["apple", "banana", "cherry", "durian"]
changelist(fruit_list)
print(fruit_list)

# If you do not want a function to change a list, pass deepcopy()

