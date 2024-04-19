#7 - Conditions
#Exercise 7.1

def convert_grade(grade):
	if grade<0 or grade >10:
		print ("Error: Grade needs to be between 0 and 10")
		return ""
	elif grade % 0.5 != 0:
		print ("Error: Grade needs to be end in .0 or .5")
		return ""
	else:
		if grade >= 8.5:
			return 'A'
		elif grade >= 7.5:
			return 'B'
		elif grade >= 6.5:
			return 'C'
		elif grade >= 5.5:
			return 'D'
		else:
			return 'F'

#Exercise 7.2
#The grade will always be "D" or "F", as the tests are placed in the incorrect order. E.g., if score is 85, then it is not only greater than 80.0, but also greater than 60.0, so that the grade becomes "D".

#Exercise 7.3

def vowel_count(s):
	count = 0
	if ("a" in s) or ("A" in s):
		count += 1
	if ("e" in s) or ("E" in s):
		count += 1
	if ("i" in s) or ("I" in s):
		count += 1
	if ("o" in s) or ("O" in s):
		count += 1
	if ("u" in s) or ("U" in s):
		count += 1
	return count

#Note: In the code above the parentheses in the boolean expressions that do the vowel testing are not necessary, but make the code more readable.
