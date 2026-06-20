"""
    Rational numbers exercise solution
"""

import math

class Rational:
    """
        A rational number
    """
    def __init__(self, numer, denom):
        self.numer, self.denom = self._reduce(numer, denom)

    @staticmethod
    def _reduce(numer, denom):
        gcd = math.gcd(numer, denom)
        if denom < 0:
            return -numer // gcd, -denom // gcd
        return numer // gcd, denom // gcd

    def __eq__(self, other):
        return self.numer == other.numer and self.denom == other.denom

    def __hash__(self):
        return hash((self.numer, self.denom))

    def __repr__(self):
        return f'{self.numer}/{self.denom}'

    def __add__(self, other):
        return Rational(
            self.numer * other.denom + other.numer * self.denom,
            self.denom * other.denom
        )

    def __sub__(self, other):
        return Rational(
            self.numer * other.denom - other.numer * self.denom,
            self.denom * other.denom
        )

    def __mul__(self, other):
        return Rational(self.numer * other.numer, self.denom * other.denom)

    def __truediv__(self, other):
        return Rational(self.numer * other.denom, other.numer * self.denom)

    def __abs__(self):
        return Rational(abs(self.numer), abs(self.denom))

    def __pow__(self, power):
        if power < 0:
            return Rational(self.denom ** -power, self.numer ** -power)
        return Rational(self.numer ** power, self.denom ** power)

    def __rpow__(self, base):
        return (base ** self.numer) ** (1 / self.denom)
