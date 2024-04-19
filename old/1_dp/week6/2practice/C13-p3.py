def customer_order_check(order_status, customer_id):
    shippedlist = []
    for cust in customer_id:
        if order_status.get(cust) is "Delivered":
            shippedlist.append(cust)
    return shippedlist # customer id who are delivered

order_statuses = {
    2001: "Pending Payment",
    2052: "Shipped",
    2003: "Processing",
    2004: "Delivered",
    2005: "Cancelled",
    2054: "Delivered",
    2065: "Cancelled",
    2100: "Shipped",
    2076: "Delivered"
}
customers = [2052, 2043, 2054, 2076, 2001]
print(customer_order_check(order_statuses, customers))
