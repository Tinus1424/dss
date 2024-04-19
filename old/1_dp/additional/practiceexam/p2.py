def manipulate_line(input_line):
    if len(input_line) <2:
        return input_line, input_line
    new_line = ''.join(sorted(input_line))
    new_line = new_line[-1] + new_line[1:-1] + new_line[0]
    return input_line, new_line


line = "feacbc"
print(manipulate_line(line))