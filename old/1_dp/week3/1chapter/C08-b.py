def process_numbers(numbers):
    total = 0
    for num in numbers:
        print(num)
        if num == 0:
            return "Done"
        elif num < 0:
            continue
        else: 
            total += num
    return total
        

print(process_numbers((12, 4, 3, 33, -2, -5, 0, 7, 22, 4)))