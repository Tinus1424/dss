"""Exercise 11.1
Write a function that receives the name of an input and an output text file as 
two strings. The function reads the contents of the input file, reverses each 
of the lines, and writes the reversed lines to the output file. The function 
does not return anything. You can use "pc_rose.txt" (from the manual) as a 
sample file to test your function:"""

# Create function reverse_lines
def reverse_lines(input_file, output_file):
    placement = ""
    with open(input_file) as fi:
        in_buffer = fi.read()
    
    with open(output_file, "w") as fo:
        split = in_buffer.split("\n")
        text = ""
        for line in split:
            text = line + "\n" + text 
        fo.write(text)
    return
    
reverse_lines("pcdata/pc_rose.txt", "pc_writetest.txt")

# -----------------------------------------------------------------------------

"""Exercise 11.2
Write a function that receives the name of an input and an output text file 
as two strings. The function reads the contents of the input file, counts the 
number of words in each line, and writes this number to the output file in a 
new line. The function does not return anything. You can use "pc_rose.txt" 
(from the manual) as a sample file to test your function:"""

# Create function count_line_words which counts words line by line.
def count_line_words(input_file, output_file):
    #counts words in each line in input_file, and writes them to output_file
    count = 0
    with open(input_file) as fi:
            in_buffer = fi.read()
        
    with open(output_file, "w") as fo:
        text = in_buffer.split("\n")
        for line in text:
            count = str(len(line)) + "\n"
            fo.write(count)
    return
    
count_line_words("pcdata/pc_rose.txt", "pc_writetest.txt")

# -----------------------------------------------------------------------------

"""Exercise 11.3
In the manual, just below Exercises, you find a file pc_bohemia.txt. Write a 
program that processes the contents of this file, line by line. It creates an 
output file in the current working directory called pc_bohemia.tmp, which has 
the same contents as pc_bohemia.txt, except that all the vowels are removed 
(case-insensitively). At the end, display how many characters you read, and 
how many characters you wrote. If you want to check the contents of 
pc_bohemia.tmp, you can either open it in a text editor, or display the first 
10 lines or so at the end of your program."""

# Create function remove_vowels.
def remove_vowels(input_file, output_file):
    # removes vowels from each line in input_file, & writes them to output_file
    vowels = "aeoui"
    voweltext = ""
    consonanttext = ""
    with open(input_file, "r") as fi:
        with open(output_file, "w") as fo:
            while True:
                in_buffer = fi.readline()
                if not in_buffer:
                    break
                for letter in in_buffer:
                    if letter in vowels or letter in vowels.upper():
                        voweltext += letter
                        continue
                    else:
                        consonanttext += letter
            fo.write(voweltext)
    with open(input_file, "w") as fw:
        fw.write(consonanttext)
    return
    
remove_vowels("pcdata/pc_rose.txt", "pc_bohemia.tmp")

# -----------------------------------------------------------------------------

"""Exercise 11.4
Read the file with the names of the politicians.txt (found in the manual, just
below Exercises). Create two lists (these can be strings for now): One with the 
first names, and one with the last names. Return both two lists."""

# Create function names_politicians
def names_politicians(ifile):
    firstname = ""
    lastname = ""
    with open("week4/3challenge/politicians.txt") as fi:
        while True:
            in_buffer = fi.readline()
            if not in_buffer:
                break
            names = in_buffer.split()
            firstname += names[0]
            lastname += names[1]
    return str(firstname), str(lastname)

# print(names_politicians("politicians.txt"))

# -----------------------------------------------------------------------------

"""Exercise 11.5
Read the file with the names of the politicians.txt (found in the manual, just
below Exercises). Save the names in a new text file (politicians_new.txt) 
after adding a column to each name indicating the total length of the name."""

# Create function length_names
def length_names(ifile):
    newline = ""
    with open(ifile) as fi:
        with open("politicians_new.txt", "w") as fn:
            while True:
                in_buffer = fi.readline()
                if not in_buffer:
                    break
                in_buffer = in_buffer.replace("\n", "")
                length = len(in_buffer)
                newline = str(in_buffer) + " " + str(length) + "\n"
                fn.write(newline)
    return
    
length_names("week4/3challenge/politicians.txt")