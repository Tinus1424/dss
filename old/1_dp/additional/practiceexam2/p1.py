"""Exercise 1: Fix a function"""

def manipulate_number(value):
    new_value = 0
    if value < 100:
        return value
    if value % 2 == 0:
        new_value = value * 2
    else:
        new_value = value - 1
    return new_value

"""Excercise 2: Fix a function"""

def manipulate_line(input_line):
    if len(input_line) == 2:
        return input_line, input_line
    new_line = ''.join(sorted(input_line))
    new_line = new_line[-1] + new_line[1:-1] + new_line[0]
    return input_line, new_line

"""Exercise 3: """
def transform_sentence(sentence, word, new_word):
    sentence = sentence.replace(word, new_word)
    if sentence.find("bananas") > -1 and sentence.find("bananas") < sentence.find("cherry") or sentence.find("cherry") == -1:
        sentence = sentence.replace("bananas", "")
    else:
        sentence = sentence.replace("cherry","CHERRY")
    return sentence

input_string = "I love apples and bananas. is my favorite!"
result = transform_sentence(input_string, "apples", "oranges")
print(result)

"""Replace word with new_word first. 
Each sentence should have the word "bananas" removed, and "cherry" capitalized 
However, if both of them are in the sentence, 
only the first occurring one should be modified."""

"""I made a mistake in the if-statement.
Because I did not account for what would happen if there was no Cherry when there was a banana.
Banana did not update without cherry"""

"""Exercise 4: find_books"""

def find_books(book_list, year_range):
    bookList = list()
    checkList = list()
    for book in book_list:
        for infoAbout in book:
            if infoAbout == "":
                book_list.remove(book)
        if book[2] in range(year_range[0], year_range[1] + 1):
            bookList.append(book[0])
    return bookList

books = [
    ["The Great Gatsby", "F. Scott Fitzgerald", 1925],
    ["To Kill A Mockingbird", "Harper Lee", 1960],
    ["1984", "George Orwell", 1949],
    ["The Hunger Games", "Suzanne Collins", 2008],
    ["The Alchemist", "Paulo Coelho", 1988],
    ["educated", "Tara Westover", 2018],
    ["The Silent Patient", "Alex Michaelides", 2019],
    ["The Midnight Library", "Matt Haig", 2020],
    ["Where The Crawdads Sing", "Delia Owens", 2018],
    ["The Da Vinci Code", "Dan Brown", 2003],
]
print(find_books(books, (2018, 2020)))

# ['Educated', 'The Silent Patient', 'The Midnight Library', 'Where The Crawdads Sing']

"""Parameters: 
book_list : list of lists — Each element contains any of the following information: 
title, author and publication year (e.g., ["1Q84", "Haruki Murakami", 2009]). 
Missing information is formatted as an empty str.

year_range : 
tuple — A range for the books of interest, 
from starting year (int), up to and including ending year (int)."""