ROMAN_NUMERAL_FOR_VALUE = {
    1: "I",
    5: "V",
    10: "X",
    50: "L",
    100: "C",
    500: "D",
    1000: "M",
}

LIMIT_ORDER_PAIRS = (
    (1000, 100), 
    (500, 100), 
    (100, 10), 
    (50, 10), 
    (10, 1), 
    (5, 1), 
    (1, 0),
)

def roman(number):
    for limit, order in LIMIT_ORDER_PAIRS:
        if number >= limit - order:
            if limit > number:
                return ROMAN_NUMERAL_FOR_VALUE[order] + roman(number + order)
            return ROMAN_NUMERAL_FOR_VALUE[limit] + roman(number - limit)
    return ""
