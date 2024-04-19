def not_identical(seq1, seq2):
    index = ""
    x = 0
    while x < len(seq1):
        if seq1[x] != seq2[x]:
            seq1ind = seq1[x]
            seq2ind = seq2[x]
            index += "Index " + str(x) + ": " + seq1ind + ", " + seq2ind + "\n"        
        x += 1
    return index
seq1 = "GAHCAGTCAGTCKGTCTAGCTAGPTAGCLAG"
seq2 = "GATCAGTCAGTCAGTCTAGCTAGCTAGCTAG"
print(not_identical(seq1, seq2))