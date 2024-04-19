def is_vowel(character):
    if len(str(character)) > 1:
        return "ONE CHARACTER ONLY"
    if character in ["a", "A", "e", "E", "i", "I", "u", "U", "o", "O"]:
        return True
    else: 
        return False
    
vowel = is_vowel("ai")
print(vowel)