def switch_sentence_parts(sentence):
    sentence = sentence.split(".")
    sentence = sentence[1] + "." + "\n" + sentence[0] + "."
    return sentence #Reversed sentence

article_snippet = """As the global markets continue to fluctuate, 
investors are closely watching for potential opportunities. 
The recent economic indicators suggest a cautious optimism, 
with some sectors showing signs of recovery."""

print(switch_sentence_parts(article_snippet))

"""The recent economic indicators suggest a cautious optimism, 
with some sectors showing signs of recovery.
As the global markets continue to fluctuate, 
investors are closely watching for potential opportunities."""