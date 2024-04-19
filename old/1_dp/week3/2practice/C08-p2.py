from random import randint, seed

def follower_target_tracker(num_followers, target_amount, set_seed):
    seed(set_seed)
    i = 0
    while num_followers < target_amount:
        num_followers += randint(1, 50)
        i += 1
    return i

iterations = follower_target_tracker(5, 530, 123)
print(iterations)