INITIAL_BALANCE = 500

def calculate_future_savings(years, interest_rate):
    init = INITIAL_BALANCE ** 3
    future = (init) * ((1 + interest_rate)**years)
    return init, round(future, 2), years

print(INITIAL_BALANCE)  # needs to be defined
print(calculate_future_savings(5, 0.05))
print(INITIAL_BALANCE)