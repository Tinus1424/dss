amount = 367
dollar = 100
quarter = 25
dimes = 10
nickels = 5
pennies = 1

amountdollars = amount // dollar 
remainderd = amount - amountdollars*dollar

amountquarter = remainderd // quarter
remainderq = remainderd - amountquarter*quarter

amountdimes = remainderq // dimes
remainderdi = remainderq - amountdimes*dimes

amountnickels = remainderdi // nickels
remaindern = remainderdi - amountnickels*nickels

amountpennies = remaindern // pennies

print("The smallest amount of coins needed to split up", amount,"is"\
,amountdollars,"dollars,", amountquarter,"quarters,",amountdimes,"dimes,"\
,amountnickels,"nickels, and", amountpennies,"pennies."  )