def total_charge(ordertxt):
    with open(ordertxt) as ot:
        total = 0
        while True:
            line = ot.readline()
            if not line:
                break
            number = int(line[-3:])
            total += number
    return total

print(total_charge("midterm/order.txt"))