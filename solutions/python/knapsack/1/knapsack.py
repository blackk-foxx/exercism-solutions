from itertools import combinations

def maximum_value(maximum_weight, items):
    max_value = 0
    for r in range(1, len(items) + 1):
        for combo in combinations(items, r):
            if sum(c["weight"] for c in combo) <= maximum_weight:
                max_value = max(max_value, sum(c["value"] for c in combo))
    return max_value
