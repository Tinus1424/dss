def extract_average_price(stock_list):
    with open(stock_list) as sl:
        in_buffer = []
        pricelist = []
        sum = 0
        while True: 
            in_buffer = sl.readline()
            if not in_buffer:
                break
            in_line = in_buffer.split(",")
            pricelist.append(in_line[2:3])
        for price in pricelist:
            pri = price.pop()
            sum += float(pri)
        average = sum / len(pricelist)
    return round(average, 3)

print(extract_average_price("week5/2practice/stock_list.txt"))