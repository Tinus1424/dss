"""Exercise 12.1
A playing card consists of a suit ("Hearts", "Spades", "Clubs", or "Diamonds") 
and a value ("Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King"). Write
a function that creates and returns a list of all possible playing cards, which
is a deck. Then create a function that shuffles the deck, producing a random
order."""

# Creating a deck.
def make_deck():
    suit = ("Hearts", "Spades", "Clubs", "Diamonds")
    values = ("Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King")
    deck = []
    for x in suit: 
        for y in values:
            deck.append(f"{y} of {x}") 
    return deck

print(make_deck())

# Shuffling a deck.
from random import random
def shuffle_deck(deck):
    deck.sort(key = lambda x: random())
    return deck

print(shuffle_deck(make_deck()))

# -----------------------------------------------------------------------------
"""Exercise 12.2
Count how often each letter occurs in a string (case-insensitively). You can 
ignore every character that is not a letter. Print the letters with their 
counts, in order from highest count to lowest count."""

text = "This is fucking bullshit mate..."

def print_letter_counts(text):
    letterlist = list(range(97, 123))
    text = text.lower()
    listcount = []
    for letter in letterlist:
        textcount = text.count(chr(letter))
        listcount.append((chr(letter), textcount))
    return  sorted(listcount, key = lambda x: x[1], reverse = True)

print(print_letter_counts(text))

# -----------------------------------------------------------------------------
"""Exercise 12.3
The sieve of Eratosthenes is a method to find all prime numbers between 1 and 
a given number using a list. This works as follows: Fill the list with the 
sequence of numbers from 1 to the highest number. Set the value of 1 to zero, 
as 1 is not prime. Now loop over the list. Find the next number on the list 
that is not zero, which, at the start, is the number 2. Now set all multiples 
of this number to zero. Then find the next number on the list that is not zero, 
which is 3. Set all multiples of this number to zero. Then the next number, 
which is 5 (because 4 has already been set to zero), and do the same thing 
again. Process all the numbers of the list in this way. When you have finished,
the only numbers left on the list are primes. Use this method to determine all 
the primes between 1 and 100."""

# Create function eratosthenes.
def eratosthenes(max_number):
    listofnumbers = list(range(0, max_number))
    listofnumbers[1] = 0
    x = 1
    while x < max_number:
        x += 1 
        y = 1
        indextozero = 0 
        while indextozero < 100:
            listofnumbers[indextozero] = 0
            y += 1
            indextozero = x * y
    return listofnumbers

print(eratosthenes(100))
# -----------------------------------------------------------------------------
"""Exercise 12.4
Write a function that receives a list with numbers and returns this list 
without numbers higher or equal than 10. For instance, for the list 
[1, 1, 32, 3, 5, 8, 10, 13, 21, 34, 55, 89] the resulting list is [1,1,3,5,8].
"""

listdas = [1, 1, 32, 3, 5, 8, 10, 13, 21, 34, 55, 89]

def remove_numbers_higher_than_ten(numbers):
    newlist = []
    for number in numbers:
        if number < 10:
            newlist.append(number)
    return newlist

print(remove_numbers_higher_than_ten(listdas))