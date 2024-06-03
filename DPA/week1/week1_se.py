import numpy as np

def convert_and_check(initial_input):
    newarray = initial_input.astype("U8")
    isEqual = np.all(initial_input == newarray)
    return newarray, isEqual
