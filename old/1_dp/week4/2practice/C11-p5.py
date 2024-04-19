from os.path import getsize

def stock_data(stock_input, stock_output):
    with open(stock_input) as fp_1:
        names = ""
        for line in fp_1:
            end = line.find(",")
            name = line[:end]
            names += name + ", "
        names = names.strip(", ")
                
    with open(stock_output, "w") as fp_2:
        fp_2.write(names)
    
    size = getsize(stock_output)
        
    return size

"""from os.path import getsize

def stock_data(stock_input, stock_output):
    with open(stock_input, 'r') as fp_1:
        names = ""
        for line in fp_1.readlines():
            start_index = 0
            end_index = line.find(",")
            name = line[start_index:end_index]
            names += name + ", "
        names = names.strip(", ")
    
    with open(stock_output, "w") as fp_2:
        fp_2.write(names)
    return getsize(stock_output)"""

print(stock_data("9_pcdata/stock_data.txt", "9_pcdata/stock_output.txt"))