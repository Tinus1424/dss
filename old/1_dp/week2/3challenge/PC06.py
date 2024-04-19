"""Exercise 6.1
Write a function that receives a string as parameter, and returns the length
of that string."""

# Create function length_test.
def length_text(text):
    length = len(text)
    return length # length of the string

# -----------------------------------------------------------------------------

"""Exercise 6.2
Write a function called seconds_in_day that receives a positive integer days as
a parameter, and returns the number of seconds in days. For example, 
seconds_in_day(5) should return 432000."""

# Create function seconds_in_day
def seconds_in_day(days):
    seconds = days * 86400
    return seconds # the number of seconds in 'days'

# -----------------------------------------------------------------------------

"""Exercise 6.3
The Pythagorean theorem states that the square of the length of the diagonal
side is equal to the sum of the squares of the lengths of the other
two sides (or 'a**2 + b**2' equals 'c**2').

Write a function 'pythagorean' that takes two parameters 'a' and 'b' that 
correspond to lengths of the two sides that meet at a right angle, and returns 
the length of the third side as a float value. You can assume that the
parameters are positive, non-zero values."""

# Create function pythagorean
def pythagorean(a,b):
    from math import sqrt
    c = pow(a, 2) + pow(b, 2)
    return sqrt(c) # the length of the third side

# -----------------------------------------------------------------------------

"""Exercise 6.4
Write a function 'convert_currency' that takes as arguments the amount of 
Euros and converts it to Dollars. Assume the current exchange rate of 1 EUR
= 1,09 USD:

Example:
amount = convert_currency(100)
print(amount) # This should be 109."""

# Create function convert_currency
def convert_currency(amount):
    amount = amount * 1.09
    return amount

# -----------------------------------------------------------------------------

"""Exercise 6.5
Write the function 'random_element' to get a single random element from a
specified string. The function receives a string 's' and always at least one 
character.

hint: you can use a function from the random module to solve this problem 
(https://docs.python.org/3/library/random.html)"""

# Create function random_element
def random_element(s):
    from random import randint
    randomIndex = randint(0, len(s))
    return s[randomIndex]

# -----------------------------------------------------------------------------

"""Exercise 6.6
Write the function 'sum_first_int' to sum of the first n positive integers. 
The program receives an integer n and prints the sum of all positive integers 
until n.

formula = (x * (x + 1))/2""" 

# Create function sum_first_int
#def sum_first_int(n):

# -----------------------------------------------------------------------------
"""Exercise 6.7
Write the function 'midpoint' to calculate midpoints (x and y) of a line. The 
program receives all 4 endpoints (x1, x2, y1, y2).

Midpoint = (x1 + x2)/2, (y1 + y2)/2"""

# Create function midpoint
def midpoint(x1, x2, y1, y2):
    midx = (x1 + x2)/2
    midy = (y1 + y2)/2
    return