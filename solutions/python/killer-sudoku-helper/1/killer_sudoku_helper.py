import itertools

def combinations(target, size, exclude):
    all_digits = set(range(1, 10))
    all_combinations = itertools.combinations(all_digits, size)
    filtered_combinations = [
        c for c in all_combinations 
        if sum(c) == target and all(d not in exclude for d in c)
    ]
    return [list(c) for c in filtered_combinations]
        