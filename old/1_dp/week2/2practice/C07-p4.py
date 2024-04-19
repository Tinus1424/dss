def determine_loyalty_status(total_purchases):
    if total_purchases > 1000:
        return "Platinum"
    elif total_purchases > 500:
        return "Gold"
    elif total_purchases > 250:
        return "Silver"
    else: 
        return "Bronze"
    
loyalty_status = determine_loyalty_status("d")
print("The customer's loyalty status is:", loyalty_status)