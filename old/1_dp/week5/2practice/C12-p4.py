from copy import deepcopy

def booking_data_transform(booking_data, special_requests, payment_status, payment_status_index):
    booking_dc = deepcopy(booking_data)
    i = 0
    for element in booking_dc:
        element.append(special_requests[i])
        i += 1
        pay = payment.pop(0)
        element.insert(payment_index, pay)
    return booking_dc


booking = [["Alice", "2024-03-15", "2024-03-20", "Deluxe Room"],
    ["Bob", "2024-04-10", "2024-04-15", "Standard Room"],
    ["Charlie", "2024-05-05", "2024-05-10", "Suite"],
    ["David", "2024-06-20", "2024-06-25", "Deluxe Room"]]
special_req = ["No special request", "vegan", "single beds", "room service included"]
payment = ["payment at arrival", "done", "pending", "done"]
payment_index = 2
print(booking_data_transform(booking, special_req, payment, payment_index))