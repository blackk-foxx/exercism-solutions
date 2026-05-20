"""
    Knapsack exercise solution
"""

from itertools import combinations

def maximum_value(maximum_weight, items):
    """
        Given a knapsack's maximum weight and a list of potential items,
        get the maximum value of the items the knapsack can carry.
    """
    max_value = 0
    for combo_length in range(1, len(items) + 1):
        for combo in combinations(items, combo_length):
            if total(combo, "weight") <= maximum_weight:
                max_value = max(max_value, total(combo, "value"))
    return max_value


def total(items, field):
    """
        Get the total value of a given field in a collection of items.
    """
    return sum(i[field] for i in items)
