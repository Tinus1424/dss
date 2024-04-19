def daily_steps(steps, max_steps):
    newlist = []
    i = 0
    for element in steps:
        newlist.append(element[1])
    newlist.sort()
    while i < 2: 
        add = newlist.pop()
        max_steps.append(add)
        i += 1
    max_steps.sort(reverse = True)
    return newlist, max_steps

step_tuple = [["Monday", 3200], ["Tuesday", 32], ["Wednesday", 8560], ["Thursday", 14500], ["Friday", 9600], ["Saturday", 16], ["Sunday", 650]]
max_steps = [23503, 13000, 17432]
print(daily_steps(step_tuple, max_steps))

