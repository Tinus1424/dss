text = """Nobody expects the SpanishInquisition!@ 
In fact, those who doexpect the Spanish Inquisition..."""

loca = text.find("@")
print(text[:loca])