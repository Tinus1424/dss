def bowling_score(input_file):
    with open(input_file) as fi:
        score = 0
        while True:
            in_buffer = fi.readline()
            if not in_buffer:
                break
            score = in_buffer.count(".")
    return score