# A list is fast if cou can access its elements directly via their index

# A dict is better if the main way to find something is by scanning items

# things like find() and in operator seem easy and read well, but if you use to find
# something in a large list, think again


from datetime import datetime

def duration_check_numbers_in_list():
    numlist = []

    for i in range(10000):
        numlist.append(i)

    start = datetime.now()

    count = 0
    for i in range(10000, 20000):
        if i in numlist:
            count += 1

    end = datetime.now()
    return(f"{(end - start).seconds}.{(end - start).microseconds} seconds",
           f"needed to find {count} numbers")

print(duration_check_numbers_in_list())

from datetime import datetime

def duration_check_numbers_in_dictionary():
    numdict = {}

    for i in range(10000):
        numdict[i] = 1

    start = datetime.now()

    count = 0
    for i in range(10000, 20000):
        if i in numdict:
            count += 1

    end = datetime.now()
    return(f"{(end - start).seconds}.{(end - start).microseconds} seconds",
           f"needed to find {count} numbers")

print(duration_check_numbers_in_dictionary())