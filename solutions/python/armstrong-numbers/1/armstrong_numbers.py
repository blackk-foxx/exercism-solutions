def is_armstrong_number(number):
    digits = get_digits(number)
    return number == sum(d ** len(digits) for d in digits)

def get_digits(number):
    if number == 0: 
        return []
    else: 
        return [number % 10, *get_digits(number // 10)]

