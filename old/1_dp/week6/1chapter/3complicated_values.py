# Dicts can also store lists and tuples
courses = {
    '880254': ['u123456', 'u383213', 'u234178'], 
    '822177': ['u123456', 'u223416', 'u234178'], 
    '822164': ['u123456', 'u223416', 'u383213', 'u234178']
}

for c in courses:
    print(c)
    for s in courses[c]:
        print(s, end=" ")
    print() # prints a new line

# Get even more complex
    courses = {
    '880254': {
        "name": "Research Skills: Data Processing", 
        "ects": 3, 
        "students": {
            'u123456': 8,
            'u383213': 7.5,
            'u234178': 6
        }
    }, 
    '822177': { 
        "name": "Understanding Intelligence",
        "ects": 6,
        "students": { 
            'u123456': 5,
            'u223416': 7,
            'u234178': 9
        } 
    }, 
    '822164': {
        "name": "Computer Games",
        "ects": 6,
        "students": {
            'u123456': 7.5,
            'u223416': 9,
            'u383213': 6,
            'u234178': 4
        }
    }
}

for c in courses:
    print(f"{c}: {courses[c]['name']} ({courses[c]['ects']})")
    for s in courses[c]['students']:
        print(f"{s}: {courses[c]['students'][s]:.1f}")
    print()

# f"" indicates a string and allows you to pass variables and other coolstuff inside of a string
# so you don't have to attach a lot of strings

# If you have a float, you can :3 to indicate 3 decimals

some_floats = [1121.33324, 111.23, 10.0]
print(f"{some_floats[0]:.3f},{some_floats[1]:.3f},{some_floats[2]:.3f}")    

# You can also do more cool stuf such as padding

message = "hi"
print(f"{message:>3}")
print(f"{message:>5}")

# Understanding dicts also allows you to understand json files

# To write to json files just import json library and json.dump(dict) to a file

# with open("file", "w") as fo: 
    # json.dump(dict, fo)