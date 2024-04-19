def clean(s1):
    s2 = ("")
    for ch in s1:
        if ch >= 'a' and ch <= 'z':
            s2 += ch
            continue
        elif ch >= "A" and ch <= "Z":
            s2 += ch.lower()
            continue
        else:
            s2 += " "
    return s2

text = "I'm, sorry, sir."

tex = clean(text)
print(tex.split())