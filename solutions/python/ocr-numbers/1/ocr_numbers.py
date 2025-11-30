NUMBER_FOR_MASK = {
    (" _ ", "| |", "|_|"): '0',
    ("   ", "  |", "  |"): '1',
    (" _ ", " _|", "|_ "): '2',
    (" _ ", " _|", " _|"): '3',
    ("   ", "|_|", "  |"): '4',
    (" _ ", "|_ ", " _|"): '5',
    (" _ ", "|_ ", "|_|"): '6',
    (" _ ", "  |", "  |"): '7',
    (" _ ", "|_|", "|_|"): '8',
    (" _ ", "|_|", " _|"): '9',
}


def convert(input_grid):
    validate(input_grid)
    groups = divide_iterable(input_grid, 4)
    return ",".join(convert_group(g) for g in groups)


def convert_group(input_grid):
    digit_grids = zip(*[ divide_line(line, 3) for line in input_grid ])
    masks = (tuple(d[:-1]) for d in digit_grids)
    return ''.join(NUMBER_FOR_MASK.get(m, '?') for m in masks)


def divide_line(line, chunk_size):
    return map(''.join, divide_iterable(line, chunk_size))


def divide_iterable(iterable, chunk_size):
    return zip(*[iter(iterable)] * chunk_size)


def validate(input_grid):
    if len(input_grid) % 4 != 0:
        raise ValueError("Number of input lines is not a multiple of four")
    if any(len(line) % 3 != 0 for line in input_grid):
        raise ValueError("Number of input columns is not a multiple of three")