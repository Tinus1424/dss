# union() returns the elements of both sets

fruit1 = {"apple", "banana", "cherry"}
fruit2 = {"banana", "cherry", "durian"}
fruitunion = fruit1.union(fruit2)
print("Union", fruitunion)
fruitunion = fruit1 | fruit2
print("Union", fruitunion)

# the operator | can also be used to make a union

# intersection() returns elements which occur in both

fruit1 = {"apple", "banana", "cherry"}
fruit2 = {"banana", "cherry", "durian"}
fruitintersection = fruit1.intersection(fruit2)
print("intersect", fruitintersection)
fruitintersection = fruit1 & fruit2
print("intersect", fruitintersection)

# & operator can test for the same 

# difference() returns only elements from first set 
# which are also not in the second

fruit1 = {"apple", "banana", "cherry"}
fruit2 = {"banana", "cherry", "durian"}
fruitdifference = fruit1.difference(fruit2)
print("diff", fruitdifference)
fruitdifference = fruit1 - fruit2
print("diff", fruitdifference)
fruitdifference = fruit2 - fruit1
print("diff", fruitdifference)

# - operator does the same 

# this function is not symmetrical as union() and intersection()
# set1 - set2 is different from set2 - set1

# isdisjoint(), issubset(), issuperset() are methods of one set
# take as argument another set and returns True or False

# isdisjoint(), True if sets share no elements

# issubset(), True if all elements in first are in second set

# issuperset, True if all elements in second are in first set

fruit1 = {"apple", "banana", "cherry"}
fruit2 = {"banana", "cherry", "durian"}
def symdif(set1, set2):
    set3 = set()
    set3.update(set1 - set2)
    set3.update(set2 - set1)
    return set3

print(symdif(fruit1, fruit2))

def wordcommon(word1, word2):
    word1set = set(word1)
    word2set = set(word2)
    word3set = word1set.intersection(word2set)
    return word3set

print(wordcommon("broodje kaas", "ham burger"))