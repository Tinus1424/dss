def calculate_bmi(weight, height):
    bmi = round(weight / pow(height, 2), 2)
    return str(bmi)

fat = calculate_bmi(55.00, 1.68)
print(fat)
