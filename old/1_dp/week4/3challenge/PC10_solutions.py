# coding: utf-8

#Exercise 10.1
# Counting vowels.
text = """And Saint Attila raised the hand grenade up on high,
saying, "O Lord, bless this thy hand grenade, that with it
thou mayst blow thine enemies to tiny bits, in thy mercy." 
And the Lord did grin. And the people did feast upon the lambs, 
and sloths, and carp, and anchovies, and orangutans, and 
breakfast cereals, and fruit bats, and large chu..."""

counta, counte, counti, counto, countu = 0, 0, 0, 0, 0
for c in text:
    if c.upper() == "A":
        counta += 1
    elif c.upper() == "E":
        counte += 1
    elif c.upper() == "I":
        counti += 1
    elif c.upper() == "O":
        counto += 1
    elif c.upper() == "U":
        countu += 1
        
print( "Counts: a={}, e={}, i={}, o={}, u={}".format( counta, counte, counto, counti, countu ) )

#Exercise 10.2
# Distilling text.
text = """The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. 
Junk MTV quiz graced by fox whelps. [Never gonna ] Bawds jog, flick quartz, vex nymphs. 
[give you up\n] Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. 
Brick quiz whangs jumpy veldt fox. [Never ] Bright vixens jump; [gonna let ] dozy fowl 
quack. Quick wafting zephyrs vex bold Jim. Quick zephyrs blow, vexing daft Jim. Charged 
[you down\n] fop blew my junk TV quiz. How quickly daft jumping zebras vex. Two driven 
jocks help fax my big quiz. Quick, Baz, get my woven flax jodhpurs! "Now fax quiz Jack!" 
my brave ghost pled. [Never ] Five quacking zephyrs jolt my wax bed. [gonna ] Flummoxed 
by job, kvetching W. zaps Iraq. Cozy sphinx waves quart jug of bad milk. [run around ] 
A very bad quack might jinx zippy fowls. Few quips galvanized the mock jury box. Quick 
brown dogs jump over the lazy fox. The jay, pig, fox, zebra, and my wolves quack! 
[and desert you] Blowzy red vixens fight for a quick jump. Joaquin Phoenix was gazed 
by MTV for luck. A wizard’s job is to vex chumps quickly in fog. Watch "Jeopardy!", 
Alex Trebek's fun TV quiz game."""

start = -1
while True:
    start = text.find( "[", start+1 )
    if start < 0:
        break
    finish = text.find( "]", start )
    if finish < 0:
        break
    print( text[start+1:finish] )
    start = finish 

#Exercise 10.3
ch = "A"
while ch <= "Z":
    print( ch )
    ch = chr( ord( ch )+1 )
print()

for i in range( 26 ):
    rotr13 = (i + 13)%26
    ch = chr( ord( "A" ) + rotr13 )
    print( ch )

#Exercise 10.4
# Counting wood.
text = """How much wood would a woodchuck chuck
If a woodchuck could chuck wood?
He would chuck, he would, as much as he could,
And chuck as much as a woodchuck would
If a woodchuck could chuck wood."""

def clean( s ):
    news = ""
    s = s.lower()
    for c in s:
        if c >= "a" and c <= "z":
            news += c
        else:
            news += " "
    return news

count = 0
for word in clean( text ).split():
    if word == "wood":
        count += 1

print( "Number of times \"wood\" occurs in the text:", count )


#Exercise 10.5
sentence = "as it turned out our chance meeting with REverend aRTHUR BElling was \
was to change our whole way of life, and every sunday we'd hurry along to St lOONY up the Cream BUn and Jam."


def autocorrect(sentence):
	# Capitalize first letter 
	newsentence = sentence[0].upper() + sentence[1:]

	splitted_sentence = newsentence.split()
	lastword = ""
	newsentence = ""

	for word in splitted_sentence:

	    # Correct double capitals
	    if len( word ) > 2 and word[0] >= "A" and word[0] <= "Z" and \
	        word[1] >= "A" and word[1] <= "Z" and word[2] >= "a" and word[2] <= "z":
	        word = word[0] + word[1].lower() + word[2:]
	    
	    # Capitalize days
	    day = word.lower()
	    if day == "sunday" or day == "monday" or day == "tuesday" or day == "wednesday" or \
	        day == "thursday" or day == "friday" or day == "saturday":
	        word = day[0].upper() + day[1:]
	    
	    # Correct CAPS LOCK
	    if word[0] >= "a" and word[0] <= "z":
	        allcaps = True
	        for c in word[1:]:
	            if not (c >= "A" and c <= "Z"):
	                allcaps = False
	                break
	        if allcaps:
	            word = word[0].upper() + word[1:].lower()
	    
	    # Remove duplicates
	    if word == lastword: 
	        continue
	        
	    newsentence += word + " "
	    lastword = word
	    
	newsentence = newsentence.strip()
	return( newsentence )