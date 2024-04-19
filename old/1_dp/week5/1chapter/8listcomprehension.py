# List comprehension is a way to consisely generate lists 
def squareslist():
    squares = []
    for i in range(1, 26):
        squares.append(i * i)
    return squares

sl = squareslist()
print(sl)

# This can be done in 
sl = [x * x for x in range(1, 26)]
print(sl)

# Say you also want to exclude numbers that end in 5
sl = [x * x for x in range(1, 26) if x % 10 != 5]
print(sl)

# but this can get quite complex
triplelist = [(x,y,z) for x in range(1, 5) 
                      for y in range(1, 5) 
                      for z in range(1, 5) 
              if x != y if x != z if y != z]
print( triplelist )

# See if you can understand this in hindsight
# A list comprehension consists of an expression in square brackets,
# followed by a for clause, 
# followed by zero or more for and/or if clauses