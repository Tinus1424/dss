def calculate_age(birth_year, current_year):
    birth_year = int(birth_year)
    current_year = int(current_year)
    age = current_year - birth_year
    return int(age)

age = calculate_age(2002, 2024)

print(age)