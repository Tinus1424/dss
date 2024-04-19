def calculate_financial_support(income, family_size):
    support = 0
    add = 0
    if income < 20000:
        support = 500
    elif 20000 <= income <= 50000:
        support = 250
    else:
        support = 0
    if int(family_size) > 4:
        add = (int(family_size) - 4) * 100  
    return support + add

fin_support = calculate_financial_support(25000, 5)
print(fin_support)