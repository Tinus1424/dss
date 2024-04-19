# Dicts are unordered collections of elements, as opposed to lists, strings, and tuples with their indices

# Every element has a key for identification

# Every element has a value for storing content 

# Dictionary syntax is {<key>: value}

fruitbasket = {"apple": 3, "banana": 5, "cherry": 50}

# To access a value, specify the key

print("Specific value:", fruitbasket["banana"])

# For loops traverse dictionaries

def traverse_dictionary(dictionary):
    for key in dictionary:
        print("Traversing", key, ':', dictionary[key])

traverse_dictionary(fruitbasket)

# KeyError, because key not in dict

# fruitbasket["tomato"]

# Adding element

fruitbasket["mango"] = 1
print("Adding mango:", fruitbasket)

# Overwrite a value

fruitbasket["mango"] = 2
print("Overwriting mango:", fruitbasket)

# delete a value

del fruitbasket["mango"]
print("Delete mango:", fruitbasket)

# len() gives number of key-value pairs.
