def manipulate_number(value):
    new_value = value
    if value < 100:
        new_value = value 
    if new_value % 2 == 0:
        new_value *= 2
    else:
        new_value = value - 1
    return new_value

print(manipulate_number(101))
