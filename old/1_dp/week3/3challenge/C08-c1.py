def print_multiplication_table(num):
    header = (".| ")
    for i in range(1, num + 1):
        header += str(i) + " "
    print(header)

    delim = ("")
    for i in range(1, len(header) + 1):
        delim += ("_")
    print(delim)

    for i in range(1, num + 1):
        rowname = (str(i) + "|")
        rowvalue = ("")
        for j in range(1, num + 1):
            rowvalue += str(i * j) + " "
        print(rowname, rowvalue)

print_multiplication_table(10)
