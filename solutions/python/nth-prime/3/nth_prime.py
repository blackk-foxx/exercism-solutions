from itertools import count

def prime(number):
    if number == 0:
        raise ValueError("there is no zeroth prime")
    return primes(number)[-1]


def primes(number):
    result = [2]
    counter = count(3, 2)
    while len(result) < number:
        x = next(counter)
        if is_prime(x, result):
            result.append(x)
    return result


def is_prime(n, known_primes):
    return all(n % p != 0 for p in filter(lambda x: x < n / 2, known_primes))

