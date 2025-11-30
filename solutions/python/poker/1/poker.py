def best_hands(hands):
    max_score = max(score(h) for h in hands)
    return [h for h in hands if score(h) == max_score]


def score(hand):
    return (
        straight_flush_score(hand, ace_high=True),
        straight_flush_score(hand, ace_high=False),
        n_of_a_kind_score(hand, 4),
        full_house_score(hand),
        flush_score(hand),
        straight_score(hand, ace_high=True),
        straight_score(hand, ace_high=False),
        n_of_a_kind_score(hand, 3),
        n_of_a_kind_score(hand, 2, group_count=2),
        n_of_a_kind_score(hand, 2),
        *sorted(get_values(hand), reverse=True)
    )


def straight_flush_score(hand, ace_high):
    return straight_score(hand, ace_high) * flush_score(hand)
    

def full_house_score(hand):
    values = get_values(hand)
    unique_values = set(values)
    value_for_count = {values.count(v): v for v in unique_values}
    is_full_house = sorted(list(value_for_count.keys())) == [2, 3]
    return value_for_count[3] if is_full_house else 0


def flush_score(hand):
    suits = [c[-1] for c in hand.split()]
    is_flush = len(set(suits)) == 1
    return max(get_values(hand)) if is_flush else 0


def straight_score(hand, ace_high):
    values = sorted(get_values(hand, ace_high))
    start, stop = values[0], values[-1] + 1
    if values == list(range(start, stop)):
        return values[-1]
    return 0


def n_of_a_kind_score(hand, n, group_count=1):
    values = get_values(hand)
    unique_values = set(values)
    group_values = set(v for v in unique_values if values.count(v) == n)
    if len(group_values) == group_count:
        return max(group_values)
    return 0
    

def get_values(hand, ace_high=True):
    return [get_card_value(c, ace_high) for c in hand.split()]


def get_card_value(card, ace_high=True):
    denom = card[:-1]
    try:
        return int(denom)
    except ValueError:
        if denom == 'A': 
            return 14 if ace_high else 1
        return 11 + 'JQK'.index(denom)
