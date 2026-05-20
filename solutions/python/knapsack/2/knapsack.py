from itertools import combinations

def maximum_value(maximum_weight, items):
    max_value = 0
    for combo_length in range(1, len(items) + 1):
        for combo in combinations(items, combo_length):
            if total(combo, "weight") <= maximum_weight:
                max_value = max(max_value, total(combo, "value"))
    return max_value


def total(combo, field):
    return sum(c[field] for c in combo)
