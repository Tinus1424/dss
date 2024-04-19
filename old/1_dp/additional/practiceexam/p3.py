def transform_sentence(sentence, word, new_word):
    newsentence = sentence.replace(word, new_word)
    if "bananas" in newsentence and "cherry" in newsentence:
        newsentence = newsentence[:newsentence.find("bananas")] + newsentence[newsentence.find("bananas") + 7:]
        newsentence = newsentence[:newsentence.find("cherry")] + newsentence[newsentence.find("cherry"): newsentence.find("cherry") + 6].upper() + newsentence[newsentence.find("cherry") + 6:]
    else:
        newsentence.replace("bananas", "")
        newsentence.replace("cherry", "CHERRY")
    return newsentence

"""def transform_sentence(sentence, word, new_word):
    sentence = sentence.replace(word, new_word)
    banana_pos = sentence.find("bananas")
    cherry_pos = sentence.find("cherry")
    if banana_pos >= 0 and (cherry_pos == -1 or banana_pos < cherry_pos):
        sentence = sentence.replace("bananas", "")
    else:
        sentence = sentence.replace("cherry", "CHERRY")
    return sentence"""


input_string = "I love apples and bananas. cherry is my favorite!"
result = transform_sentence(input_string, "apples", "oranges")
print(result)