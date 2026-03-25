def to_ordinal(number: int) -> str:
    suffix_for_tail = {"1": "st", "2": "nd", "3": "rd"}
    number_as_str = str(number)
    if number_as_str[-2:] in {"11", "12", "13"}:
        suffix = "th"
    else:
        suffix = suffix_for_tail.get(number_as_str[-1], "th")
    return f"{number}{suffix}"


def line_up(name: str, number: int) -> str:
    return f"{name}, you are the {to_ordinal(number)} customer we serve today. Thank you!"
