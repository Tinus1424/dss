def market_cap_average(stock_data):
    pricelist = []
    for key in stock_data.keys():
        pricelist.append(stock_data[key].get("market_cap"))
    return round(sum(pricelist) / len(pricelist))

stocks = {
    "AAPL": {
        "price": 150.25,
        "volume": 5000000,
        "market_cap": 2000000000,
        "sector": "Technology",
    },
    "GOOGL": {
        "price": 2750.50,
        "volume": 1200000,
        "market_cap": 1500000000,
        "sector": "Technology",
    },
    "MSFT": {
        "price": 300.75,
        "volume": 3000000,
        "market_cap": 1800000000,
        "sector": "Technology",
    },
    "AMZN": {
        "price": 3500.20,
        "volume": 800000,
        "market_cap": 1600000000,
        "sector": "Retail",
    },
    "TSLA": {
        "price": 800.00,
        "volume": 1500000,
        "market_cap": 1000000000,
        "sector": "Automotive",
    },
    "NFLX": {
        "price": 600.50,
        "volume": 700000,
        "market_cap": 900000000,
        "sector": "Entertainment",
    },
    "AMD": {
        "price": 120.50,
        "volume": 900000,
        "market_cap": 300000000,
        "sector": "Technology",
    },
    "NVDA": {
        "price": 220.40,
        "volume": 800000,
        "market_cap": 280000000,
        "sector": "Technology",
    },
}
print(market_cap_average(stocks))