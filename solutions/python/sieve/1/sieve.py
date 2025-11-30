UNMARKED = 0
NOT_PRIME = 1
PRIME = 2

def primes(limit):
    upper_bound = limit + 1
    status = [UNMARKED] * upper_bound
    for n in range(2, upper_bound):
        if status[n] == UNMARKED:
            status[n] = PRIME
            for m in range(n * 2, upper_bound, n):
                status[m] = NOT_PRIME
    return [i for i in range(2, upper_bound) if status[i] == PRIME]
        
