from itertools import permutations
from functools import reduce


def solve(puzzle):
    formula, symbolic_sum = (x.strip() for x in puzzle.split("=="))
    addends = list(x.strip() for x in formula.split("+"))
    letters = set("".join(addends + [symbolic_sum]))
    digits = range(0, 10)
    for perm in permutations(digits, len(letters)):
        mapping = dict(zip(letters, perm))
        if mapping_resolves(mapping, addends, symbolic_sum):
            return mapping
    return None

def mapping_resolves(mapping, addends, symbolic_sum):
    if not mapping_is_valid(mapping, addends, symbolic_sum):
        return False
    return sum(make_numeric(mapping, a) for a in addends) == make_numeric(mapping, symbolic_sum)

def mapping_is_valid(mapping, addends, symbolic_sum):
    return all(is_valid(mapping, t) for t in addends + [symbolic_sum])

def make_numeric(mapping, symbol):
    digits = [mapping[l] for l in symbol]
    return reduce(lambda a, d: a * 10 + d, digits, 0)

def is_valid(mapping, symbol):
    return mapping[symbol[0]] != 0