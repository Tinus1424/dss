# .keys() iterates all keys, .values() does for values, .items() does both

# THESE METHODS DO NOT LIST BUT ITERATE, CHECK THE DIFFERENCE BETWEEN FIRST TWO AND LAST ONE

# THESE METHODS ARE THUS ITERATORS

fruitbasket = {"apple": 3, "banana": 5, "cherry": 50}

print(fruitbasket.keys())
print(fruitbasket.values())
print(list(fruitbasket.items()))

fruitbasket = {"apple": 3, "banana": 5, "cherry": 50, "durian": 0, "mango": 2}

# an iterator can be passed to a for loop and also to functions
for key in fruitbasket.keys():
    print(key, ':', fruitbasket[key])
    
print(sum(fruitbasket.values()))

# iterators are preferred over lists because they only provide when requested, thus less memory used

# .get() retrieves a value safely even if you do not know it exists

fruitbasket = {"apple": 3, "banana": 5, "cherry": 50, "durian": 0, "mango": 2}

def fruit_exists(fruitbasket, item):
    there = ""
    if not fruitbasket.get(item):
        there = "not"
    return item + " is " + there + " in the basket"
        
print(fruit_exists(fruitbasket, "apple"))
print(fruit_exists(fruitbasket, "orange"))

banana = fruitbasket.get("banana", 0)
print("number of bananas in the basket:", banana)

strawberry = fruitbasket.get("strawberry", 0)
print("number of strawberries in the basket:", strawberry)

# .copy() 
fruitbasket = {"apple": 3, "banana": 5, "cherry": 50}
fruitbasketalias = fruitbasket
fruitbasketcopy = fruitbasket.copy()

print(id(fruitbasket))
print(id(fruitbasketalias))
print(id(fruitbasketcopy))

# Many list methods also work on dicts

# .update() is the dict version for .append()

fruitbasket = {"apple": 3, "banana": 5, "cherry": 50}
fruitbasket.update({"tomato": 0, "dragon fruit": 1})
print(fruitbasket)

# practice

wordlist = ["apple", "durian", "banana", "durian", "apple", "cherry",
            "cherry", "mango", "apple", "apple", "cherry", "durian",
            "banana", "apple", "apple", "apple", "apple", "banana",
            "apple"]

def word_dictionary_list(word_list):
    worddict = {}
    wordcount = 0
    for word in wordlist:
        if word in worddict:
            continue
        wordcount = wordlist.count(word)
        worddict.update({word: wordcount})
    return "WORDDICT", worddict # a dictionary with words as key, and their
            # frequency in word_list as value

print(word_dictionary_list(wordlist))

csv = "apple,durian,banana,durian,apple,cherry,cherry,mango,apple," + \
      "apple,cherry,durian,banana,apple,apple,apple,apple,banana,apple"
    
def word_dictionary_csv(word_text):
    text = csv.split(sep= ",")
    text = word_dictionary_list(text)
    return  text # a dictionary with words as key, and their frequency
            # in word_text as value

print(word_dictionary_csv(csv))

english_dutch = {
    "last": "laatst", "week": "week", "the": "de", "royal": "koninklijk", 
    "festival": "feest", "hall": "hal", "saw": "zaag", "first": "eerst",
    "performance": "optreden", "of": "van", "a": "een", "new": "nieuw", 
    "symphony": "symphonie", "by": "bij", "one": "een", 
    "world": "wereld", "leading": "leidend", "modern": "modern",
    "composer": "componist", "composers": "componisten", "two": "twee",
    "shed": "schuur", "sheds":"schuren"
}

def translate(english_text):
    translation = "" 
    for element in english_text:
        punctuation = ",:;!?'\"."
        if element in punctuation:
            english_text = english_text.replace(element, "")

    english_list = english_text.split()
    for word in english_list:
        engword = english_dutch.get(word.lower())
        if engword == None:
            engword = word
        translation = translation + " " + engword
    return translation

# a word-by-word translation of english_text to dutch 

sentence = "Last week The Royal Festival Hall saw the first performance \
of a new symphony by one of the world's leading modern composers, \
Arthur \"Two-Sheds\" Jackson."
print(translate(sentence))