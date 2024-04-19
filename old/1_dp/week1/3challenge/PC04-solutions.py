# 4 - Expressions

# Exercise 4.1
print(60 * (0.6 * 24.95 + 0.75) + (3 - 0.75) )

# Or, if you want your output to look a bit nicer:

print(int(100 * (60 * (0.6 * 24.95 + 0.75) + (3 - 0.75))) / 100)

# Easier ways of formatting displays will be introduced in a later chapter.

# Exercise 4.2
# Each of the lines should be either print("A message") or print('A message').
# The error in the first line is that it ends in a period. That period should 
# be removed. The error in the second line is that it contains something that 
# is supposed to be a string, but starts with a double quote while it ends 
# with a single quote. Either the double quote should become a single quote, 
# or the single quote should become a double quote. The third line is actually 
# syntactically correct, but probably it was meant to be print( 'A message' ), 
# so the f" should be removed.

# Exercise 4.3
print(1 / 0)

# Exercise 4.4
# The problem is that there is one closing parenthesis missing in the first 
# line of code. I actually deleted the closing parenthesis that should be right
# of the 6, but you cannot know that; you can only count the parentheses in the
# first statement and see that there is one less closing parenthesis than there
# are opening parentheses.

# The confusing part of this error message is that it says that the error is in
# the second line of code. The second line of the code, however, is fine. The
# reason is that since Python has not seen the last required closing
# parenthesis on the first line, it starts looking for it on the second line.
# And while doing that, it notices that something is going wrong, and it
# reports the error. Basically, while trying to process the second line, Python
# finds that it cannot do that, so it indicates that there is an error with the
# second line.

# You will occasionally encounter this in your own code: an error is reported
# for a certain line of code, but the error is actually made in one of the
# previous lines. Such errors often encompass the absence of a required
# parenthesis or single or double quote. Keep this in mind.

# Exercise 4.5
print(str((14 + 535) % 24 ) + ".00")

