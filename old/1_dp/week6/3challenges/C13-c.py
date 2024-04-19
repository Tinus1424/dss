"""Exercise 13.1
Write a program that takes the string in the text variable, splits it into 
words (where everything that is not a letter is considered a word boundary), 
and case-insensitively builds a dictionary that stores for 
every word how often it occurs in the text. Then print all the words with their 
quantities in alphabetical order."""

# Create a function word_counting.
text = """How much wood would a woodchuck chuck
If a woodchuck could chuck wood?
He would chuck, he would, as much as he could,
And chuck as much as a woodchuck would
If a woodchuck could chuck wood."""

def wordcounting(text):
    text = text.split()
    textlist = []
    countdict = {}
    for word in text:
        word = word.strip("?,.")
        word = word.lower()
        textlist.append(word)
    for word in textlist:
        value = textlist.count(word)
        countdict.update({word: value})
    sortdict = list(countdict.items())
    sortdict.sort(key = lambda x: x[1], reverse = True)
    countdict = dict(sortdict)
    return countdict

print(wordcounting(text))
# -----------------------------------------------------------------------------

"""Exercise 13.2
Write a function that reads the contents of an input file, splits it into 
words (where everything that is not a letter is considered a word boundary), 
and case-insensitively builds and returns a dictionary that stores for every 
word how often it occurs in the text. Write another function that takes such a 
dictionary as a parameter, and prints all its words with their quantities in 
alphabetical order. The second function does not return anything."""

# Create function count_words 
def count_words(input_file):
    with open(input_file) as fi:
        in_buffer = fi.read()
        word_dict = wordcounting(in_buffer)
    return word_dict

def print_words(word_dict):
    word_dict = list(word_dict.items())
    word_dict.sort(key = lambda x: x)
    for element in word_dict:
        print(element[0], element[1])
    return

print_words(count_words("week6/3challenges/woodchuck.txt"))  # NOTE: from Files chapter

# -----------------------------------------------------------------------------

"""Exercise 13.3
The code block below shows a list of movies. For each movie it also shows a 
list of ratings. Convert this code in such a way that it stores all this data 
in one dictionary, then use the dictionary to print the average rating for 
each movie, rounded to one decimal."""

# Create function movie_ratings.
movies = ["Monty Python and the Holy Grail", 
          "Monty Python's Life of Brian",
          "Monty Python's Meaning of Life",
          "And Now For Something Completely Different"]

grail_ratings = [9, 10, 9.5, 8.5, 3, 7.5, 8]
brian_ratings = [10, 10, 0, 9, 1, 8, 7.5, 8, 6, 9]
life_ratings = [7, 6, 5]
different_ratings = [6, 5, 6, 6]

def movie_ratings(movies, movie1, movie2, movie3, movie4):
    moviedictionary = {}
    movielist = [movie1, movie2, movie3, movie4]
    x = 0
    while x < len(movies):
        moviedictionary.update({movies[x]: movielist[x]})
        x += 1
    return moviedictionary

dictionarymovie = movie_ratings(movies, grail_ratings, brian_ratings, life_ratings, different_ratings)        
new = {}
for element in dictionarymovie.keys():
    
    value = dictionarymovie.get(element)
    average = sum(value) / len(value)
    new.update({element: average})
print(new)


    

# -----------------------------------------------------------------------------

"""Exercises 13.4
A library contains books. Books have a writer, identified by last name and 
first name. Books also have a title. Books also have a location number that 
identifies where they can be found in the library. Librarians want to be able 
to locate a specific book if they know writer and title, and they want to be 
able to list all the books that they have of a specific writer. What data 
structure would you use to store the books?"""

# A dictionary

library = {
    "book1":{
        "last_name" : "fillername",
        "first_name" : "fillerfirst",
    }
}