from typing import Iterable
import math


ALPHABET_LENGTH = 26
CHUNK_SIZE = 5


def encode(plain_text: str, a: int, b: int) -> str:
    assert_coprime(a, ALPHABET_LENGTH)
    encoded_chars = (
        encode_char(c, a, b, ALPHABET_LENGTH) 
        for c in normalized(plain_text)
    )
    return "".join(chunked(encoded_chars)).strip()


def decode(ciphered_text: str, a: int, b: int) -> str:
    assert_coprime(a, ALPHABET_LENGTH)
    decoded_chars = (
        decode_char(c, a, b, ALPHABET_LENGTH) 
        for c in normalized(ciphered_text)
    )
    return "".join(decoded_chars)


def normalized(text: str) -> str:
    return text.replace(" ", "")


def chunked(sequence: Iterable[str]) -> Iterable[str]:
    count = 0
    for char in (c for c in sequence if c):
        yield char
        count += 1
        if count % CHUNK_SIZE == 0:
            yield " "


def encode_char(char: str, a: int, b: int, m: int) -> str:
    if char.isalpha():
        index = index_for_letter(char)
        return letter_for_index((a * index + b) % m)
    if char.isnumeric():
        return char
    return ""


def decode_char(char: str, a: int, b: int, m: int) -> str:
    if char.isalpha():
        index = index_for_letter(char)
        return letter_for_index(pow(a, -1, m) * (index - b) % m)
    return char


def index_for_letter(letter: str) -> int:
    return ord(letter.lower()) - ord("a")


def letter_for_index(index: int) -> str:
    return chr(index + ord("a"))


def assert_coprime(a: int, m: int) -> None:
    if math.gcd(a, m) > 1:
        raise ValueError("a and m must be coprime.")
