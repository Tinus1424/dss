
# 5 - Variables
# Exercise 5.1
# This program calculates the average of three variables, var1, var2, and var 3
var1 = 12.83
var2 = 99.99
var3 = 0.12
average = (var1 + var2 + var3) / 3 # Calculate the average by adding up the
                                   # values and dividing by 3
print(average)  # May look a bit ugly, we might make this look a bit better
                # when we have learned about formatting

# Exercise 5.2
pi = 3.14159
radius = 12
print("The surface area of a circle with radius", radius, "is",
      pi * radius * radius)

# Exercise 5.3
CENTS_IN_DOLLAR = 100
CENTS_IN_QUARTER = 25
CENTS_IN_DIME = 10
CENTS_IN_NICKEL = 5

amount = 1156
cents = amount

dollars = int(cents / CENTS_IN_DOLLAR)
cents -= dollars * CENTS_IN_DOLLAR
quarters = int(cents / CENTS_IN_QUARTER)
cents -= quarters * CENTS_IN_QUARTER
dimes = int(cents / CENTS_IN_DIME)
cents -= dimes * CENTS_IN_DIME
nickels = int(cents / CENTS_IN_NICKEL)
cents -= nickels * CENTS_IN_NICKEL
cents = int(cents)

print("$"+str( amount / CENTS_IN_DOLLAR ), "consists of:")
print("Dollars:", dollars)
print("Quarters:", quarters)
print("Dimes:", dimes)
print( "Nickels:", nickels)
print("Pennies:", cents)

# Exercise 5.4
a = 17
b = 23
print("a =", a, "and b =", b)
a += b
# add two more lines of code here to ensure the swapping of a and b
b = a - b 
a -= b   
print("a =", a, "and b =", b)