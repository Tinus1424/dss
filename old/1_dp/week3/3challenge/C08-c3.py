def largest(number_collection):
    large = 0
    for i in number_collection:
        if i > large:
            large = i
    return large

numbers = (123, 412, 523, 9)
lar = largest(numbers)
print("Largest", lar)

def smallest(number_collection):
    small = 0
    for i in number_collection:
        if small == 0: 
            small = i
        elif i < small:
            small = i
    return small

sma = smallest(numbers)
print("Smallest is", sma)

def dividables_by3(number_collection):#
    i = 0
    for x in number_collection:
        print("outer", x)
        if (x % 3) == 0:
            print("inner loop", x)
            i += 1
    return i


dv = dividables_by3(numbers)
print(dv)

