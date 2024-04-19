from random import randint, seed
def holiday_booking_verification(max_attempts, set_seed):
    seed(set_seed)
    i = 0
    while i < max_attempts:
        i += 1
        is_booked = randint(0, 1)
        payment_status = randint(0, 1)
        if is_booked == 0:
            print("Sorry, your booking could not be verified. Please check your booking details")
            continue
        elif payment_status == 0:
            print("Payment not completed. Please complete the payment to finalize your booking.")
            continue
        elif is_booked == 1 & payment_status == 1:
            print("Booking verified! Enjoy your holiday!")
            break
        else:
            break
    return i

num_attempts = holiday_booking_verification(3, 45)
print(num_attempts)