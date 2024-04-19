import random

def simulate_voter_turnout(min_act_voters, max_act_voters, min_total_voters, max_total_voters):
    av = random.randint(min_act_voters, max_act_voters)
    tv = random.randint(min_total_voters, max_total_voters)
    vt = (av / tv)
    return vt

random.seed(42)
voterturnout = simulate_voter_turnout(10, 100, 100, 1000)
print(voterturnout)