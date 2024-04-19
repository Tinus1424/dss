from pcinput import getFloat

num1 = getFloat("Please enter an integer: ")
num2 = getFloat("Please enter another integer: ")
num3 = getFloat("Please enter a final integer: ")

maxnum = max(num1, num2, num3)
minnum = min(num1, num2, num3)
average = ((num1 + num2 + num3) / 3)

print("The largest number is {:.2f}, the smallest number \
is {:.2f},and the average of the three numbers is \
{:.2f}.".format(maxnum, minnum, average))