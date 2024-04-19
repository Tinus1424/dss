# List methods change the list because LISTS ARE MUTABLE UNLIKE TUPLES

# Appending, append adds only a single element to the end of the list, this can be a list
my_list = ["computer", "Roos", "NFL"]
my_list.append("koffietje")
print(my_list)

my_list.append(["koffietje", "mealprep"])
print(my_list)

## Using the + operator is the same as appending and lets you save to a new variable, but append is more efficient

# extend() attaches multiple elements at the end of a list, extending a list with a list does not result in a nexted list

my_list = ["computer", "Roos", "NFL"]
my_list.extend(["koffietje", "mealprep"])
print(my_list)

my_list.extend("knuffel")
print(my_list) # Extending with a string makes every element within the string an element within the list

# insert() can insert an element into a specific position
my_list = ["computer", "Roos", "NFL"]
my_list.insert(1, "koffietje")
print(my_list)

my_list.insert(1, ["koffietje", "knuffel"])
print(my_list) # inserst an acutal list

# remove() allows you to remove but only the first occurence is removed
my_list = ["computer", "Roos", "NFL"]
my_list.remove("computer") # this works
# my_list.remove(["computer", "Roos"]) # this does not work because it searches for the list within the list
# my_list.remove("computer", "Roos") # this does not work because it only takes one argument
my_list.remove(my_list[0]) # this works
print(my_list)

# pop() pops the last item of the list
my_list = ["computer", "Roos", "NFL"]

print(my_list.pop()) # Returns the popped element
print(my_list.pop()) # Returns the next, method is good for working through lists

# index() returns index of FIRST OCCURENCE, value error if element not found
my_list = ["computer", "Roos", "NFL"]

print(my_list.index("computer"))

#count 
my_list = ["computer", "Roos", "NFL"]
print(my_list.count("computer")) #takes on arg and counts the element

# sort()
my_list = ["computer", "Roos", "NFL"]

my_list.sort()
print("sorted with case difference," ,my_list) # sorts on alphabetic order, capitals come first, if you have mutiple elements it is symbols > numbers > capitals
# it can only sort lists with a single type, even mixing int with float does not work
# sorted() returns a sort() list but without changing the original
# sort(reverse = True) returns a descending order list

# Keys
# Python sorts on the key of the value in the list, if you do not assign a key then the key is the value itself
# we can assign key by
my_list.sort(key = str.lower)
print("Sorted based on same case", my_list) 

# Custom keys

#This one by the last digit of the element
def revert_digits(element):
    int_as_str = str(element)
    reverse_str = int_as_str[::-1]  # remember that [::-1] reverses a collection
    return int(reverse_str)

numlist = [314, 315, 642, 246, 129, 999]
numlist.sort(key=revert_digits)
print(numlist)

#This one does by length
def by_len(element):
    return len(element) 

fruit_list = ["apple", "strawberry", "banana", "raspberry", "cherry", 
              "banana", "durian", "blueberry"]
fruit_list.sort(key=by_len)
print(fruit_list)

# second key criterion, filters first on the first element and then the second
def by_len_alphabetical(element):
    return len(element), element 

fruit_list = ["apple", "strawberry", "banana", "raspberry", "cherry", 
              "banana", "durian", "blueberry"]
fruit_list.sort(key=by_len_alphabetical)
print(fruit_list)

## Anonymous functions (lambda expressions)
# Useful for specifying the key because it keeps it at the sort
my_list = ["computer", "Roos", "NFL", "Doos"]

my_list.sort(key = lambda x: (len(x), x))
print(my_list)

# lambda works like def, everything after lamba, "x" in this case
# is the input parameter and : works the same as with def

# reverse() is the same as sort(reversed = True)

# del is a keyword that delets object in memory
del my_list[1]
print(my_list)

# Tasks

numlist = [-10, -7, -3, -2, 0, 1, 2, 5, 7, 8, 10]
numlist.sort(key = int.__abs__)
print(numlist)

# Letter counting.
text = """Now, it's quite simple to defend yourself against a man
armed with a banana. First of all you force him to drop the banana; then,
second, you eat the banana, thus disarming him. You have now rendered
him helpless."""

wordlist = [0] * 26

for letter in text:
    letter = letter.lower()
    if not ord(letter) in range(ord("a"), ord("z")):
        continue
    wordlist[ord(letter) - ord("a")] += 1
    print(letter)
print(wordlist)
