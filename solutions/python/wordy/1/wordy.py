from enum import Enum


def answer(question: str) -> int:
    words = question[:-1].split()
    return parse(words)


def parse(words: list[str]) -> int:

    class State(Enum):
        INITIAL = 0,
        READ_OP = 1,
        READ_VALUE = 2,

    result = 0
    state = State.INITIAL
    for word in words:
        if word in ("What", "is", "by"):
            continue
        match state:
            case State.INITIAL:
                result = to_int(word)
                state = State.READ_OP
            case State.READ_OP:
                func = get_func_for_op(word)
                state = State.READ_VALUE
            case State.READ_VALUE:
                result = func(result, to_int(word))
                state = State.READ_OP
    if state in (State.INITIAL, State.READ_VALUE):
        raise ValueError("syntax error")
    return result


def to_int(word: str) -> int:
    try:
        return int(word)
    except ValueError:
        raise ValueError("syntax error")


def get_func_for_op(op: str) -> callable:
    try:
        return {
            "plus": lambda a, b: a + b,
            "minus": lambda a, b: a - b,
            "multiplied": lambda a, b: a * b,
            "divided": lambda a, b: a // b,
        }[op]
    except KeyError:
        if is_int(op):
            raise ValueError("syntax error")
        raise ValueError("unknown operation")


def is_int(word: str) -> bool:
    try:
        int(word)
        return True
    except ValueError:
        return False
