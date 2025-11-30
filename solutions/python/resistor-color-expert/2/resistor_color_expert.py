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

TOLERANCE_FOR_COLOR = {
    "grey": "0.05%",
    "violet": "0.1%",
    "blue": "0.25%",
    "green": "0.5%",
    "brown": "1%",
    "red": "2%",
    "gold": "5%",
    "silver": "10%",
}

def get_value(colors):
    return reduce(lambda a, c: a * 10 + COLOR_FOR_VALUE.index(c), colors, 0)


def format_float(value):
    if value == math.floor(value):
        value = int(value)
    return str(value)
    

def format_resistance(ohms):
    order = int(math.log10(ohms) / 3) if ohms > 0 else 0
    mantissa = ohms / (1000 ** order)
    return f"{format_float(mantissa)} {PREFIX_FOR_ORDER[order]}ohms"


def format_tolerance(color):
    return "±" + TOLERANCE_FOR_COLOR[color]


def resistor_label(colors):
    if len(colors) == 1:
        ohms = get_value(colors)
        return format_resistance(ohms)
    else:
        value = get_value(colors[0:-2])
        zeroes = get_value(colors[-2:-1])
        tolerance_color = colors[-1]
        ohms = value * 10 ** zeroes
        return format_resistance(ohms) + " " + format_tolerance(tolerance_color)
