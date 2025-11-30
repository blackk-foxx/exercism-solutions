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

def get_value(colors):
    return reduce(lambda a, c: a * 10 + COLOR_FOR_VALUE.index(c), colors, 0)


def format(ohms):
    order = int(math.log10(ohms) / 3) if ohms > 0 else 0
    mantissa = ohms // (1000 ** order)
    return f"{mantissa} {PREFIX_FOR_ORDER[order]}ohms"


def label(colors):
    value = get_value(colors[:2])
    zeroes = get_value(colors[2:3])
    ohms = value * 10 ** zeroes
    return format(ohms)
