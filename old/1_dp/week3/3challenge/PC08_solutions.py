#Exercise 8.1 and 8.2
def print_multiplication_table(n):
	header = ". |"
	total_blanks = (len(str(n*n)) +1)
	for i in range(1,n+1):
		header +=  (total_blanks-len(str(i))) * ' ' + str(i) 
	print(header)
	print("-" *len(header))
	for i in range(1,n+1):
		s = ""
		for j in range(1,n+1):
			num = i*j
			amount_blanks = total_blanks - len(str(num))
			s +=(amount_blanks*' ' + str(num)) 
		print(str(i) + " |" + s)

def print_multiplication_table(n):
	header = ". |"
	total_blanks = (len(str(n*n)) +1)
	i=1
	while i < n+1:
		header +=  (total_blanks-len(str(i))) * ' ' + str(i) 
		i+=1
	print(header)
	print("-" *len(header))
	i=1
	while i < n+1:
		s = ""
		for j in range(1,n+1):
			num = i*j
			amount_blanks = total_blanks - len(str(num))
			s +=(amount_blanks*' ' + str(num)) 
		print(str(i) + " |" + s)
		i+=1

#Exercise 8.3
def largest(number_collection):
	largest = 0
	for num in number_collection:
		if num > largest:
			largest = num
	return largest

def smallest(number_collection):
	smallest = largest(number_collection)
	for num in number_collection:
		if num < smallest:
			smallest = num
	return smallest

def dividables_by3(number_collection):
	count = 0
	for num in number_collection:
		if num %3 == 0:
			count +=1
	return count

#Exercise 8.4
def bottle_song(bottles):
	s = "s"
	while bottles != "no":
		print( "{0} bottle{1} of beer on the wall, {0} bottle{1} of beer.".format( bottles, s ) )
		bottles -= 1
		if bottles == 1:
			s = ""
		elif bottles == 0:
			s = "s"
			bottles = "no"
		print( "Take one down, pass it around, {} bottle{} of beer on the wall.".format( bottles, s ) )

#Exercise 8.5
def print_fibonacci(maximum):
	num1 = 0
	num2 = 1
	print(1)
	while True:
		num3 = num1 + num2
		if num3 > maximum:
			break
		print(num3)
		num1 = num2
		num2 = num3   

#Exercise 8.6
def isPrime(number):
	if number < 2:
		return False
	else:
		i = 2
		while i*i <= number:
			if number%i == 0:
				return False
				break
			i += 1
		else:
			return True

#Exercise 8.7
def print_sum_squares(a,b):
	for i in range( a, b ):
		for j in range( 1, i ):
			for k in range( j, i ):
				if j*j + k*k == i:
					print( "{} = {}**2 + {}**2".format( i, j, k ) )

#Exercise 8.8
for A in range( 1, 10 ):
	for B in range( 10 ):
		if B == A:
			continue
		for C in range( 10 ):
			if C == A or C == B:
				continue
			for D in range( 1, 10 ):
				if D == A or D == B or D == C:
					continue
				num1 = 1000*A + 100*B + 10*C + D
				num2 = 1000*D + 100*C + 10*B + A
				if num1 * 4 == num2:
					print( "A={}, B={}, C={}, D={}".format( A, B, C, D ) )