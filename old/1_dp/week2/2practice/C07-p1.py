def is_even_number_of_transactions(total_transactions):
    whole_number = total_transactions // 2
    wra = total_transactions / 2
    if whole_number == wra: 
        return True
    else: 
        return False
    
evenornot = is_even_number_of_transactions(1113)

print(evenornot)
