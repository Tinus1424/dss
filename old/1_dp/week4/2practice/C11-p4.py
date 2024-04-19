def average_char_num(sales_data):

    with open(sales_data) as sd:
        length = 0
        count = 0
        while True:
            in_buffer = sd.readline()
            length += len(in_buffer)
            if in_buffer == "":
                break
            count += 1
    return round(length / count)

print(average_char_num("9_pcdata/sales_data.txt"))