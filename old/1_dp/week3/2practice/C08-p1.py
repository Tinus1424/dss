def count_vowels(text):
    vowel = ("a", "e", "i", "o", "u")
    vowelupper = ("A", "E", "I", "O", "U")
    j = 0
    for i in text:
        if i in vowel or i in vowelupper:
            j += 1
    return j


quote = "Can machines think?"
vowel_count_quote = count_vowels(quote)
print(vowel_count_quote)