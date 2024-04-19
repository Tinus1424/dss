def print_nonequal_pairs(maximum):
    for i in range(1, maximum, 2):
        for j in range(i, maximum, 2):
            print(" ", i, ",", j)


print_nonequal_pairs(8)

