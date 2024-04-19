from os.path import exists

def replace_characters(customer_data):
    if exists(customer_data) == False:
        return ""
    with open(customer_data) as cd:
        cd = cd.read()
        cd = cd.replace(",", "|")
        cd = cd.replace("@", "[at]")
    return cd

print(replace_characters("9_pcdata/customer_data.txt"))