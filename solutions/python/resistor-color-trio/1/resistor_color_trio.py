import math

COLOR_BY_VALUE = [
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

PREFIX_FOR_THOUSANDS = [
    "",
    "kilo",
    "mega",
    "giga",
]

def value(colors):
    if len(colors) == 1:
        return COLOR_BY_VALUE.index(colors[0])
    return COLOR_BY_VALUE.index(colors[0]) * 10 + COLOR_BY_VALUE.index(colors[1])


def format(ohms):
    if ohms > 0:
        thousands = int(math.log10(ohms) / 3)
    else:
        thousands = 0
    if thousands > 0:
        base = ohms // (1000 ** thousands)
    else:
        base = ohms
    return str(base) + " " + PREFIX_FOR_THOUSANDS[thousands] + "ohms"


def label(colors):
    base = value(colors[:2])
    zeroes = value(colors[2:3])
    ohms = base * 10 ** zeroes
    return format(ohms)
