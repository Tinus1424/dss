from random import randint, seed

def simulate_stock_value(stocks, num_years, growth_rate, price_threshold, set_seed):
    i = 0
    seed(set_seed)
    for stock in stocks:
        init = randint(1, 100)
        print(stock)
        value = 0
        j = 0
        for y in range(1, num_years + 1):
            value += init * (1 + growth_rate) ** y
            j += 1
            if value > price_threshold:
                print("Exceeded")
                break
            print("Value of", stock, "in year", y, "is", value)
        i += j
                
            

    return i # Number of iterations

stock_steps = simulate_stock_value(
    stocks=("SPY", "GME", "NVDA"),
    num_years=6,
    growth_rate=0.05,
    price_threshold=120,
    set_seed=42
)
print(stock_steps)