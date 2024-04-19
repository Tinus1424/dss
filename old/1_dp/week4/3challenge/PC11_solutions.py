#Exercise 11.1
def reverse_lines(input_file, output_file):   
	ifile = open(input_file)
	ofile = open(output_file, "w")
	for line in ifile:
		line = line.strip()
		ofile.write(line[::-1] + "\n")
	ifile.close()
	ofile.close()

#Exercise 11.2
def count_line_words(input_file, output_file):
	ifile = open(input_file)
	ofile = open(output_file, "w")
	for line in ifile:
		line = line.split(" ")
		length_words = len(line)
		ofile.write(str(length_words) + "\n")
	ifile.close()
	ofile.close()

#Exercise 11.3
def remove_vowels(input_file, output_file):
	ifile = open(input_file)
	ofile = open(output_file, "w")
	for l in ifile:
		for c in "aieuo":
			l = l.replace(c, "")
		ofile.write(l)
	ifile.close()
	ofile.close()

#Exercise 11.4
def names_politicians(ifile):
	inf = open(ifile)
	list_fn = []
	list_ln = []
	buffer = inf.readlines()
	for line in buffer:
		first_name = line.split()[0]
		last_name = line.split()[1]
		list_fn.append(first_name)
		list_ln.append(last_name)	 
	inf.close()
	return list_fn, list_ln

#Exercise 11.5
def length_names(ifile):
	inf = open(ifile)
	outf = open("politicians_new.txt", "w")
	buffer = inf.readlines()
	for line in buffer:
		name_length = len(line.strip().replace(" ", ""))
		newline = line.strip() + ", " + str(name_length) + "\n" 
		outf.write(newline)
	inf.close()
	outf.close()