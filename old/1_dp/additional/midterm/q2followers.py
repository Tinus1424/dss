def get_followers(n_followers, t_followers):
    if n_followers <= 0 or t_followers < n_followers:
        return False
    i = 0
    while n_followers < t_followers:
        n_followers = n_followers * 1.1
        i += 1
    return i

print(get_followers(5, 4))