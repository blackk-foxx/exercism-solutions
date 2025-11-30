def prime(number):
    if number == 0:
        raise ValueError("there is no zeroth prime")
    return primes(number)[-1]


def primes(number):
    if number == 1:
        return [2]
    result = [2, 3]
    while len(result) < number:
        result.append(next_prime(result))
    return result


def next_prime(known_primes):
    n = known_primes[-1] + 2
    while not is_prime(n, known_primes):
        n += 2
    return n


def is_prime(n, known_primes):
    possible_divisors = filter(lambda p: p < n / 2, known_primes)
    return all(n % p != 0 for p in possible_divisors)
