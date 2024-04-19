def check_authentication(username, password):
    if username in ["student", "teacher"]:
        return False
    if len(password) < 8:
        return False
    else: 
        return True
    
authentication_result = check_authentication("teacasdher", "Khkasdasdsadih")
print("Valid authentication:", authentication_result)
authentication_result = check_authentication("mastudentgpie_56", "Kb76hkih")
print("Valid authentication:", authentication_result)