def multi3_odd(start, finish):
    i = 0
    for number in range(start, finish + 1):
        if number % 2 == 0:
            continue
        elif number % 3 == 0:
            i += 1
    return i #Int reflecting how many odd numbers between start
#and finish divisible by 3

test_output = multi3_odd(1, 10)
print("a test:", test_output)