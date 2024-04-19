def is_palindrome(input):
    input2 = input[::-1]
    if input2 == input:
        return True
    else:
        return False

print(is_palindrome("madam"))
