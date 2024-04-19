from random import random, seed
from math import exp, log
def simulate_future_value(initial_amount, year, seed_value):
    seed(seed_value)
    interest = random()
    futurevalue = initial_amount * (exp(interest * year))
    return round(log(futurevalue), 4)

money = simulate_future_value(1000, 5, 123)
print(money)


