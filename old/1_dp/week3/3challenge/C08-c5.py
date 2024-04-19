def print_fibonacci(maximum):
    start = 0
    successor = 1
    next = 0
    fib = ("1")
    while successor < maximum:
        next = start + successor
        start = successor
        successor = next
        fib += ", " + str(next)
    return fib

fibo = print_fibonacci(29)
print(fibo)