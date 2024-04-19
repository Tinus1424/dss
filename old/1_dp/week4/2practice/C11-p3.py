"""from os.path import exists
#def append_lines(house_data_1, house_data_2):
    if exists(house_data_1) == False or exists(house_data_2) == False:
        return ""
    
    with open(house_data_1) as hd:
        count = 0
        text = ""
        for line in hd:
            if count == 6:
                break
            count += 1
            text += line
            print(text)

    with open(house_data_2, "a") as h2:
        h2 = h2.write(text)
    return len(text)
"""

from os.path import exists

def append_lines(house_data_1, house_data_2):
    if not exists(house_data_1) or not exists(house_data_2):
        return ""    

    count = 0
    text = ""
    for line in open(house_data_1, 'r'):
        if count > 6:
            break
        count += 1
        text += line

    with open(house_data_2, 'a') as out_buffer:
        out_buffer.write(text)
    
    return len(text)

print(append_lines("9_pcdata/houses_1.txt", "9_pcdata/houses_2.txt"))