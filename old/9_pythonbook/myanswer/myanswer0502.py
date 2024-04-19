from pcinput import getFloat
import math

a = getFloat("Please enter the length of side a: ")
b = getFloat("Please enter the length of side b: ")
print("The length of C = ", math.sqrt(pow(a, 2)+pow(b, 2)))
