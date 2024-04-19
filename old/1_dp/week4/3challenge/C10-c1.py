"""Exercise 10.1
Count how many of each vowel (a, e, i, o, u) there are in the text string in 
the string 'text' below, and print the count for each vowel with a single 
formatted string. Remember that vowels can be both lower and uppercase."""

# Create function counting vowels.
text = """And Saint Attila raised the hand grenade up on high,
saying, "O Lord, bless this thy hand grenade, that with it
thou mayst blow thine enemies to tiny bits, in thy mercy." 
And the Lord did grin. And the people did feast upon the lambs, 
and sloths, and carp, and anchovies, and orangutans, and 
breakfast cereals, and fruit bats, and large chu..."""

def vowelcount(text):
    A = 0
    E = 0
    I = 0
    O = 0
    U = 0
    for letter in text:
        if letter == "":
            break
        elif letter == "A" or letter == "a":
            A += 1
        elif letter == "E" or letter == "e":
            E += 1
        elif letter == "I" or letter == "i":
            I += 1
        elif letter == "O" or letter == "o":
            O += 1 
        elif letter == "U" or letter == "u":
            U += 1
    return "A = {}, E = {}, I = {}, O = {}, U = {}".format(A, E, I, O, U)

# print(vowelcount(text))


# -----------------------------------------------------------------------------

"""Exercise 10.2
The text string in the 'text' variable below contains several words which are 
enclosed by square brackets ([ and ]). Scan the string and print out all words 
which are between square brackets. For example, if the text string would be 
"[a]n example[ string]", you are expected to print out "a string"."""

# Create function distilling text.
text = """The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax 
quiz prog. Junk MTV quiz graced by fox whelps. [Never gonna ] Bawds jog, flick 
quartz, vex nymphs. [give you up\n] Waltz, bad nymph, for quick jigs vex! Fox 
nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt fox. [Never ] 
Bright vixens jump; [gonna let ] dozy fowl quack. Quick wafting zephyrs vex 
bold Jim. Quick zephyrs blow, vexing daft Jim. Charged [you down\n] fop blew 
my junk TV quiz. How quickly daft jumping zebras vex. Two driven jocks help 
fax my big quiz. Quick, Baz, get my woven flax jodhpurs! "Now fax quiz Jack!" 
my brave ghost pled. [Never ] Five quacking zephyrs jolt my wax bed. [gonna ] 
Flummoxed by job, kvetching W. zaps Iraq. Cozy sphinx waves quart jug of bad 
milk. [run around ] A very bad quack might jinx zippy fowls. Few quips 
galvanized the mock jury box. Quick brown dogs jump over the lazy fox. The 
jay, pig, fox, zebra, and my wolves quack! [and desert you] Blowzy red vixens 
fight for a quick jump. Joaquin Phoenix was gazed by MTV for luck. A wizard's 
job is to vex chumps quickly in fog. Watch "Jeopardy!", Alex Trebek's fun TV 
quiz game."""

def distil(text):
    text = text.split("[")
    wordlist = ""
    for word in text:
        if not "]" in word:
            continue
        index = word.find("]")
        wordlist += word[:index]
    return wordlist

# print(distil(text))

# -----------------------------------------------------------------------------

"""Exercise 10.3
Print a line of all the capital letters "A" to "Z". Below it, print a line of 
the letters that are 13 positions in the alphabet away from the letters that 
are above them. E.g., below the "A" you print an "N", below the "B" you print 
an "O", etcetera. You have to consider the alphabet to be circular, i.e., 
after the "Z", it loops back to the "A" again.

Hint: you can use ord() to convert a character to an int, and chr() to
      convert an int to a character (e.g., ord('a'), and chr(97)).
"""

# ROTR-13.
# Create function letters

def linechar():
    atoz = ""
    ztoa = ""
    for letter in range(ord("A"), ord("Z")):
        atoz += chr(letter)
    for i in atoz:
        ztoa += chr(ord(i) + 13)
    for j in ztoa:
        if ord(j) >= 90:
            x = ord(j) - 90
            ztoa = ztoa.replace(j, chr(65 + x))
    return atoz + "\n" + ztoa

#print(linechar()) 

# -----------------------------------------------------------------------------
 
"""Exercise 10.4
In the text below, count how often the word "wood" occurs (using program code, 
of course). Capitals and lower case letters may both be used, and you have to 
consider that the word "wood" should be a separate word, and not part of 
another word. Hint: If you did the exercises from this chapter, you already 
developed a function that "cleans" a text. Combining that function with the 
'split()' function more or less solves the problem for you."""

# Counting wood.
text = """How much wood would a woodchuck chuck
If a woodchuck could chuck wood?
He would chuck, he would, as much as he could,
And chuck as much as a woodchuck would
If a woodchuck could chuck wood."""
def clean(s1):
    s2 = ("")
    for ch in s1:
        if ch >= 'a' and ch <= 'z':
            s2 += ch
            continue
        elif ch >= "A" and ch <= "Z":
            s2 += ch
            continue
        else:
            s2 += " "
    return s2

def cleanwood(text):
    cleantext = clean(text)
    wordlist = cleantext.split()
    i = 0
    for word in wordlist:
        if word == "wood":
            i += 1
    return i
    

##print(cleanwood(text))
# -----------------------------------------------------------------------------

"""Exercise 10.5
Typical autocorrect functions are the following: (1) if a word starts with 
two capitals, followed by a lower-case letter, the second capital is made 
lower case; (2) if a sentence contains a word that is immediately followed by 
the same word, the second occurrence is removed; (3) if a sentence starts with 
a lower-case letter, that letter is turned into a capital; (4) if a word 
consists entirely of capitals, except for the first letter which is lower case, 
then the case of the letters in the word is reversed; and (5) if the sentence 
contains the name of a day (in English) which does not start with a capital, 
the first letter is turned into a capital. Write a function that takes a 
sentence as a parameter and returns its auto-corrected version."""

s = "wOrd with two capitals, sentence sentence double. new sentence without capital, cAPITAL error, friday without capital."

def doublecapital(sentence):
    words = sentence.split()
    newsentence = ""
    for word in words:
        if ord(word[0]) in range(65, 91) and ord(word[1]) in range(65, 91):
            word = word.replace(word[1], word[1].lower())
            
        newsentence += word + " "
    return newsentence

def doubledouble(sentence):
    words = sentence.split()
    wordinmemory = ""
    newsentence = ""
    for word in words:
        if word == wordinmemory:
            continue
        else:
            newsentence += word + " "
        wordinmemory = word
    return newsentence

def firstlower(sentence):
    newsentence = ""
    wordinmemory = ""
    words = sentence.split()
    for word in words:
        if "." in wordinmemory or wordinmemory == "":
            word = word.replace(word[0], word[0].upper())
        newsentence += word + " "
        wordinmemory = word
    return newsentence
        
def capitalerror(sentence):
    newsentence = ""
    words = sentence.split()
    for word in words:
        if ord(word[0]) in range(ord("a"), ord("z") + 1) and word[1:len(word)] == word[1:len(word)].upper():
            word = word.replace(word[0], word[0].upper())
            word = word.replace(word[1:len(word)], word[1:len(word)].lower())
        newsentence += word + " "
    return newsentence

def capitalday(sentence):
    newsentence = ""
    words = sentence.split()
    for word in words:
        if word[-3:] == "day":
            word = word.replace(word[0], word[0].upper())
        newsentence += word + " "
    return newsentence

def frankenauto(sentence):
    sentence = doubledouble(sentence)
    sentence = firstlower(sentence)
    sentence = capitalerror(sentence)
    sentence = capitalday(sentence)
    sentence = doublecapital(sentence)
    return sentence

print(frankenauto(s))

#print(capitalday(s))
#print(capitalerror(s))

#print(firstlower(s))  
# print(doublecapital(s)) 
#print(doubledouble(s))