from itertools import combinations_with_replacement
from functools import partial
from collections import defaultdict

def smallest(min_factor, max_factor):
    """Given a range of numbers, find the smallest palindromes which
    are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
    Iterable should contain both factors of the palindrome in an arbitrary order.
    """
    input_range = range(min_factor * min_factor, max_factor * max_factor)
    return get_first_palindrome_and_factors(input_range, min_factor, max_factor)


def largest(min_factor, max_factor):
    """Given a range of numbers, find the largest palindromes which
       are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
             Iterable should contain both factors of the palindrome in an arbitrary order.
    """
    input_range = range(max_factor * max_factor, min_factor * min_factor, -1)
    return get_first_palindrome_and_factors(input_range, min_factor, max_factor)


def get_first_palindrome_and_factors(input_range, min_factor, max_factor):
    validate(min_factor, max_factor)
    palindromes = filter(is_palindrome, input_range)
    factor_range = range(min_factor, max_factor+1)
    has_factors_in_range = partial(is_divisible_by_factors_in_range, factor_range)
    try:
        result = next(filter(has_factors_in_range, palindromes))
    except StopIteration:
        return None, []
    else:
        factors = get_factors_for_n(result, factor_range)
        return result, factors


def validate(min_factor, max_factor):
    if min_factor > max_factor:
        raise ValueError("min must be <= max")


def is_divisible_by_factors_in_range(factor_range, n):
    min_factor = factor_range.start
    max_factor = factor_range.stop - 1
    for x in factor_range:
        if n % x == 0 and min_factor <= n / x <= max_factor:
            return True
    return False


def get_factors_for_n(n, all_factors):
    combos = combinations_with_replacement(all_factors, 2)
    return list(filter(lambda a: a[0] * a[1] == n, combos))


def is_palindrome(n):
    digits = get_digits(n)
    return digits == digits[::-1]


def get_digits(n):
    result = []
    while n > 0:
        result.append(n % 10)
        n = n // 10
    return result
