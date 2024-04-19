def identify_age_group(age):
    if 0 <= age <= 14:
        return "Child (0-14 years)"
    elif 15 <= age <= 64:
        return "Adult (15-64 years)"
    elif age >= 65:
        return "Senior (65 years or above)"

print(identify_age_group(-1))
