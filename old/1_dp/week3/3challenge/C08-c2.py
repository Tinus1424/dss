def print_multiplication_table(num):
    header = (". |")
    i = 0
    while i < num:
        i += 1
        header += str(i) + " "
    print(header)

    i = 0
    delim = ("")
    while i < len(header):
        i += 1
        delim += ("_")
    print(delim)

    i = 0
    while i < num:
        i += 1
        rowname = str(i) + "|"
        rowvalue = ("")
        j = 0
        while j < num:
            j += 1
            rowvalue += str(i * j) + " "
        print(rowname, rowvalue)

print_multiplication_table(10)