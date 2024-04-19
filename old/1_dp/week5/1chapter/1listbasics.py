mylist = ["Computers", "Football", "Exercise", "Data Science", 5, 0.4]
# Lists are ordered, the order of the item is important not the contents
# In contrast to dictionaries where order is not important

for loop in mylist:
    print(loop, type(loop)) # We can loop through a list


# Lists can be summed, minned, and maxed, but only if the datatypes are okay with that
mynumberlist = [4, 5.4, 3, 7, 6.4]
print("SUM!", sum(mynumberlist), "MIN!", min(mynumberlist), "MAX!", max(mynumberlist))

print("Data Science in my list?", "Data Science" in mylist) # Returns true
print("Poop in my list?", "Poop" in mylist) # Returns False

fruit_list = ["apple", "banana", "cherry", "durian", "orange"]
i = 0
while i < len(fruit_list):
    print("Looping:", fruit_list[i])
    i += 1

    


