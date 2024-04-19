
#6 - Simple Functions
#Exercise 6.1
def length_text(text):
	return len(text)

#Exercise 6.2
def seconds_in_day(days):
	return days*24*60*60

#Exercise 6.3
import math
def pythagorean(a,b):
	return math.sqrt(a*a + b*b)


#Exercise 6.4
def convert_currency(euro):
	converted = euro * 1.09 
	converted = round(converted, 2)
	return converted

#Exercise 6.5
import random

def random_element(s):
	print(random.choice(s))

#Exercise 6.6
def sum_first_int(n):
	sum_num = (n * (n + 1)) / 2
	return(sum_num)

#Exercise 6.7
def midpoint(x1,x2,y1,y2):
	x_mid = (x1+x2) / 2
	y_mid = (y1+y2) / 2
	return x_mid, y_mid