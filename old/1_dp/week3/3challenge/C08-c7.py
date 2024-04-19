def print_sum_squares(a, b):
    y = 0
    z = 0
    while y < b:
        y += 1
        for x in range(y):
            z = x**2 + y ** 2
            if z < a:
                continue
            if z > b:
                break
            print(z,"=",x, "**2 +",y, "**2")
    return 

print_sum_squares(45, 96)