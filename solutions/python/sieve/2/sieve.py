def primes(limit):
    not_prime = set()
    result = []
    upper_bound = limit + 1
    for n in range(2, upper_bound):
        if n not in not_prime:
            result.append(n)
            not_prime.update(range(n * 2, upper_bound, n))
    return result
        
