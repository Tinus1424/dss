fruit_list = ["apple", "banana"] + ["cherry", "durian"] 
print(fruit_list)

fruit_list = fruit_list * 2
print(fruit_list)

def multiply_list(item_list):
    return item_list * 10

print(multiply_list(fruit_list)) # Returns the fruit list 10 *, one after another
print(multiply_list(fruit_list[0])) # Only multiplies apple (first in the list, because lists are ordered)

def add_to_list(fruit_list, item):
    fruit_list += item
    return fruit_list

print(add_to_list(fruit_list, "apple")) # Splits apple up into individual pieces and attaches those to the list
print(add_to_list(fruit_list, ["apple"])) #Adds apple after the last index because it is a list being added to a list

print(["Apple", "Roos"] + "ik") # does not work because it can only add list to list 