def freq_histogram(word_freqs): 
    freqs = list(word_freqs.values())
    freqsdict = {}
    for number in freqs:
        value = freqs.count(number)
        key = number
        freqsdict.update({key: value})
    histogram = list(freqsdict.values())
    return histogram

print(freq_histogram({'absurd': 0, 'thought': 2, 'wood': 1, 'one': 2,'tree':1}))