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

def identify_age_group(age):
    if 0 <= age <= 14:
        return "Child (0-14 years)"
    elif 15 <= age <= 64:
        return "Adult (15-64 years)"
    elif age >= 65:
        return "Senior (65 years or above)"
    
def analyze_and_display(income, family_size, age):
    support = calculate_financial_support(income, family_size)
    age = identify_age_group(age)
    return support, age

print(analyze_and_display(50000, 7, 56))
    