def change_customer_data(path_to_file, file_name, prefix, replacement):
    filepath = path_to_file + file_name
    prefixstring = str(prefix) + "-"
    replacementstring = str(replacement) + "-"
    filestring = ""
    with open(filepath) as fp:
        for line in fp:
            if prefixstring in line:
                newline = line.replace(prefixstring, replacementstring)
                filestring += newline
    return filestring #string that can be written to a file 


print(change_customer_data("practiceexam/", "customer_info.csv", 55, 111))

