def prime(number):
    if number == 0:
        raise ValueError("there is no zeroth prime")
    return primes(number)[-1]


def primes(number):
    result = [2]
    x = 3
    for n in range(1, number):
        while any(x % p == 0 for p in result):
            x += 1
        result.append(x)
    return result
