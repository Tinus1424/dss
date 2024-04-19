def stringprint(string):
    vowels = "aeoiu"
    for vowel in range(0, len(string)):
        if string[vowel] in vowels:
            print(string[vowel])
        else:
            continue
    
s = "And now for something completely differente"
stringprint(s)
