def len_customer_id(customer_id_1, customer_id_2):
    len1 = len(str(customer_id_1))
    len2 = len(str(customer_id_1))
    max_id = max(len1, len2)
    return max_id

longest = len_customer_id("asdasda", "sadsadsadsadsadsad")
print(longest)