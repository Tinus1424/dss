def sort_stocks(stocks, baseline):
    liststocks = list(stocks.items())
    liststocks.sort(key = lambda x: x[0])
    liststocks.sort(key = lambda x:sum(x[1]) / len(x[1]), reverse = True)
    returnlist = list()
    for x in liststocks:
        returnlist.append(x[0])
    return returnlist


stocks = {
    '$BSZnc': [1, 1],
    '$MSFT': [417, 416, 425, 415, 415, 404, 406],
    '$NVDA': [884, 878, 879, 908, 919, 857, 875],
    '$BSAr2': [1, 1]
}
print(sort_stocks(stocks, 0))