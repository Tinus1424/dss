def extract_age(data_record):
    x = data_record.find("Age:")
    age = (data_record[x + 5:x + 7])
    good = age.replace(",", " ")
    return good



record = "Name: Jane Smith, Age: , Occupation: Analyst"
print(extract_age(record))