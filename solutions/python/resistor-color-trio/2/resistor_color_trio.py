import math
from functools import reduce

COLOR_FOR_VALUE = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white",
]

PREFIX_FOR_ORDER = [
    "",
    "kilo",
    "mega",
    "giga",
]

def value(colors):
    return reduce(lambda a, c: a * 10 + COLOR_FOR_VALUE.index(c), colors, 0)


def format(ohms):
    if ohms >= 1000:
        order = int(math.log10(ohms) / 3)
        base = ohms // (1000 ** order)
    else:
        order = 0
        base = ohms
    return str(base) + " " + PREFIX_FOR_ORDER[order] + "ohms"


def label(colors):
    base = value(colors[:2])
    zeroes = value(colors[2:3])
    ohms = base * 10 ** zeroes
    return format(ohms)
