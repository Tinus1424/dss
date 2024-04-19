"""Exercise 7.1
Grades are values between zero and 10 (both zero and 10 included), and are 
always rounded to the nearest half point. To translate grades to the American 
style, 8.5 to 10 become an "A", 7.5 and 8 become a "B", 6.5 and 7 become a "C",
5.5 and 6 become a "D", and other grades become an "F". Write a function that 
implements this translation and returns the American translation of the value 
in the parameter 'grade'. If 'grade' is lower than zero or higher than 10, the
function prints an error message and returns an empty string. You do not need 
to handle grades that do not end in .0 or .5, though you may do that if you 
like -- in that case, print an appropriate error message."""

# Create function convert_grade
def convert_grade(grade):
    if 0 > grade or grade > 10:
        return str()
    if grade < 5.5:
        return "F"
    elif grade < 6.5:
        return "D"
    elif grade < 7.5:
        return "C"
    elif grade < 8.5:
        return "B"
    else:
        return "A"


# -----------------------------------------------------------------------------

"""Exercise 7.2
Can you spot the reasoning error in the following function?"""

# Find the reasoning error 
def give_grade(score):
    if score >= 60.0:
        grade = 'D'
    elif score >= 70.0:
        grade = 'C'
    elif score >= 80.0:
        grade = 'B'
    elif score >= 90.0:
        grade = 'A'
    else:
        grade = 'F'
    return grade

# -----------------------------------------------------------------------------

"""Exercise 7.3
Define a function that receives a string parameter, and returns an integer 
indicating how many different vowels there are in the string. The capital 
version of a lower case vowel is considered to be the same vowel. y is not 
considered a vowel. For example, for the string "Michael Palin", the function 
should return 3."""

# Create function vowel_count
def vowel_count(text):
    vowels = "aeiou"
    i = 0
    for vowel in vowels:
        if vowel in text or vowel.upper() in text: 
            i += 1
    return i # number of different vowels in text

print(vowel_count("MichAel PAlin"))