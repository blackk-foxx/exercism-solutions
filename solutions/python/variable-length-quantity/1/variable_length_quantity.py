from itertools import chain

def encode(numbers):
    return list(chain(*[encode_number(n) for n in numbers]))

def encode_number(n):
    result = []
    while True:
        byte = n & 0x7F | 0x80
        result.append(byte)
        n = n >> 7
        if n == 0:
            break
    result[0] &= 0x7F
    return reversed(result)


def decode(bytes_):
    validate(bytes_)
    result = []
    value = 0
    for b in bytes_:
        value = value << 7 | b & 0x7F
        if not b & 0x80:
            result.append(value)
            value = 0            
    return result


def validate(bytes_):
    if bytes_[-1] & 0x80 == 0x80:
        raise ValueError("incomplete sequence")