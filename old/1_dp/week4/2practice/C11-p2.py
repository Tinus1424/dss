def write_data(country_data_input, country_data_output, dir_name):
    file = dir_name + country_data_input
    file2 = dir_name + country_data_output
    with open(file) as fp:
        with open(file2, "w") as fc:
            text = fp.read()
            fc = fc.write(text)
    return None

write_data("government_data_input.txt", "government_data_output.txt", "9_pcdata/")