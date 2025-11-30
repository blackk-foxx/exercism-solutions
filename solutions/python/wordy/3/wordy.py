from enum import Enum
import itertools
from typing import Any, Iterator


def answer(question: str) -> int:
    return reduce(preprocess(tokenize(question.replace("?", ""))))


def tokenize(text: str) -> Iterator[str]:
    for token in text.split():
        yield token


def preprocess(tokens: list[str]) -> Iterator[Any]:
    significant_tokens = filter(lambda w: w not in ("What", "is", "by"), tokens)
    symbols = map(int_or_str, significant_tokens)
    return symbols


def reduce(symbols: Iterator[str]) -> int:
    try:
        result = next(symbols)
        for operator, operand in batched(symbols, 2):
            if type(operator) is int:
                raise ValueError("syntax error")
            func = get_func_for_op(operator)
            result = func(result, operand)
    except (StopIteration, TypeError):
        raise ValueError("syntax error")
    return result


def batched(items: Iterator[Any], n: int) -> Iterator[list[Any]]:
    while True:
        batch = list(itertools.islice(items, n))
        if batch:
            batch.extend([None] * (n - len(batch)))            
            yield batch
        else:
            break


def get_func_for_op(op: str) -> callable:
    try:
        return {
            "plus": lambda a, b: a + b,
            "minus": lambda a, b: a - b,
            "multiplied": lambda a, b: a * b,
            "divided": lambda a, b: a // b,
        }[op]
    except KeyError:
        raise ValueError("unknown operation")


def int_or_str(word: str) -> int | str:
    try:
        return int(word)
    except ValueError:
        return word
