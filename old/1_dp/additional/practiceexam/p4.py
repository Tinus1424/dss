def find_books(book_list, year_range):
    newlist = list()
    for book in book_list:
        if len(book) != 3:
            continue
        if book[2] in range(year_range[0], year_range[1] + 1):
           newlist.append(book[0]) 
    for book in newlist:
        booktest = book.split()
        for x in booktest:
            if x[0] == x[0].lower():
                newlist.remove(book)
    return newlist


books = [
    ["The Great Gatsby", "F. Scott Fitzgerald", 1925],
    ["To Kill A Mockingbird", "Harper Lee", 1960],
    ["1984", "George Orwell", 1949],
    ["The Hunger Games", "Suzanne Collins", 2008],
    ["The Alchemist", "Paulo Coelho", 1988],
    ["educated", "Tara Westover", 2018],
    ["The Silent Patient", "Alex Michaelides", 2019],
    ["The Midnight Library", "Matt Haig", 2020],
    ["Where The Crawdads Sing", "Delia Owens", 2018],
    ["The Da Vinci Code", "Dan Brown", 2003],
    ["Asddsa Asdad", "", 2020]
]
print(find_books(books, (2018, 2020)))