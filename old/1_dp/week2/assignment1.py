def internship_days(income, travel_costs, rent, other_expenses):
    if income < 0 or travel_costs < 0 or rent < 0 or other_expenses < 0:
        return "Inputs must be at least 0"
    rest = income - rent - other_expenses
    days = rest / (travel_costs * 2)
    if days > 30:
        return int(30)
    if days < 0:
        return int(0)
    return int(days)

print(internship_days(1000, 12, 0, 100))