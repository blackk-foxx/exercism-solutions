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

def value(colors):
    return COLOR_BY_VALUE.index(colors[0]) * 10 + COLOR_BY_VALUE.index(colors[1])
