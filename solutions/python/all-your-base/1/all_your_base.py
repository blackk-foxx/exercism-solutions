def validate(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    if output_base < 2:
        raise ValueError("output base must be >= 2")
    for d in digits:
        if not (0 <= d < input_base):
            raise ValueError("all digits must satisfy 0 <= d < input base")


def find_value(digits, base):
    value = 0
    for i, d in enumerate(reversed(digits)):
        value += d * base ** i
    return value


def find_digits(value, base):
    result = []
    while value > 0:
        value, remainder = divmod(value, base)
        result.append(remainder)
    return list(reversed(result))
    

def rebase(input_base, digits, output_base):
    validate(input_base, digits, output_base)
    value = find_value(digits, input_base)
    result = find_digits(value, output_base)
    if not result:
        result = [0]
    return result