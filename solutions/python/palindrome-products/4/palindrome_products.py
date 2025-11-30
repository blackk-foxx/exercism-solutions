from itertools import combinations_with_replacement
from typing import Iterable, Optional

IntPair = tuple[int, int]


def smallest(min_factor: int, max_factor: int) -> tuple[Optional[int], Iterable[IntPair]]:
    """Given a range of numbers, find the smallest palindromes which
    are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
    Iterable should contain both factors of the palindrome in an arbitrary order.
    """
    validate(min_factor, max_factor)
    products = range(min_factor * min_factor, max_factor * max_factor + 1)
    factors = range(min_factor, max_factor + 1)
    return get_first_palindrome_and_factors(products, factors)


def largest(min_factor: int, max_factor: int) -> tuple[Optional[int], Iterable[IntPair]]:
    """Given a range of numbers, find the largest palindromes which
       are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
             Iterable should contain both factors of the palindrome in an arbitrary order.
    """
    validate(min_factor, max_factor)
    products = range(max_factor * max_factor, min_factor * min_factor - 1, -1)
    factors = range(min_factor, max_factor + 1)
    return get_first_palindrome_and_factors(products, factors)


def validate(min_factor: int, max_factor: int):
    if min_factor > max_factor:
        raise ValueError("min must be <= max")


def get_first_palindrome_and_factors(products: range, factors: range) -> tuple[Optional[int], Iterable[IntPair]]:
    for n in filter(is_palindrome, products):
        if first_factor_pair := find_first_factor_pair_for_n(n, factors):
            potential_remaining_factors = range(first_factor_pair[0] + 1, first_factor_pair[1])
            remaining_factors = get_factor_pairs_for_n(n, potential_remaining_factors)
            factor_pairs = [first_factor_pair, *remaining_factors]
            return n, factor_pairs
    return None, []


def find_first_factor_pair_for_n(n: int, factors: range) -> Optional[IntPair]:
    min_factor = factors.start
    max_factor = factors.stop - 1
    for x in get_factors_for_n(n, factors):
        y = n // x
        if min_factor <= y <= max_factor:
            return x, y
    return None


def get_factors_for_n(n: int, factors: range) -> Iterable[int]:
    return filter(lambda x: n % x == 0, factors)


def get_factor_pairs_for_n(n: int, factors: range) -> Iterable[IntPair]:
    combos = combinations_with_replacement(factors, 2)
    return filter(lambda a: a[0] * a[1] == n, combos)


def is_palindrome(n: int) -> bool:
    digits = str(n)
    return digits == digits[::-1]
