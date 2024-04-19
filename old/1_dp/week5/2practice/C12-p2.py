def rate_movies(movie_data):
    highestratedscore = 0
    highestratedmovie = []
    movie_data = list(movie_data)
    for element in movie_data:
        if element[1] > highestratedscore:
            highestratedscore = element[1]
            highestratedmovie = element
    return highestratedmovie


movie_data_tuples = (("Inception", 8.7),
    ("The Shawshank Redemption", 9.3),
    ("Jurassic Park", 7.9),
    ("Titanic", 7.8),
    ("The Dark Knight", 9.0),
    ("Forrest Gump", 8.8),
    ("Pulp Fiction", 8.9),
    ("The Godfather", 9.2),
    ("Avatar", 7.8),
    ("The Matrix", 8.7),
    ("The Lord of the Rings: The Fellowship of the Ring", 8.8))
print(rate_movies(movie_data_tuples))