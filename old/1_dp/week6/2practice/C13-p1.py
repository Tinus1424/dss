def website_traffic_analysis(visited_pages):
    visitcount = dict()
    i = 0
    while i < len(visited_pages):
        page = visited_pages.pop(0)
        if page in visitcount:
            continue
        if not page:
            break
        pagecount = visited_pages.count(page)
        visitcount.update({page: pagecount + 1})
        i += 1
    return visitcount# dictionary o

pages = [
    'Products',
    'Home',
    'Contact',
    'Products',
    'Birthday Cakes',
    'Our Story',
    'Catering',
    'Products',
    'Birthday Cakes',
    'Our Story',
    'Contact',
    'Home',
    'Contact',
    'Birthday Cakes',
    'Our Story'
]
print(website_traffic_analysis(pages))