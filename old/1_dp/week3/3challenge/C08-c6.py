def is_prime(number):
    i = 0
    while i < number: 
        i += 1
        if i == 1:
            continue
        elif number == 2:
            return True
        elif number % i == 0: 
            return False
        if i == number // 2 + 1:
            return True
        
pri = is_prime(103)
print(pri)
            