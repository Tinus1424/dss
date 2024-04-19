def population_growth(growth_rate, init_population, years):
    month = int(years) * 12
    pop = init_population
    while month != 0:
        pop += pop * (1 + growth_rate)
        print(month, round(pop, 3))
        month -= 1
    return round(pop, 3)

pop_growth = population_growth(0.08, 100, 1)
print(pop_growth)
