import enum
from collections import defaultdict, namedtuple
from functools import cache
from itertools import product, pairwise

Attributes = namedtuple('Attributes', ['number', 'nationality', 'color', 'animal', 'drink', 'hobby'])

class Nationality(enum.Enum):
    Englishman = 'Englishman'
    Spaniard = 'Spaniard'
    Ukrainian = 'Ukrainian'
    Norwegian = 'Norwegian'
    Japanese = 'Japanese'


class Color(enum.Enum):
    Red = 'red'
    Yellow = 'yellow'
    Green = 'green'
    Blue = 'blue'
    Ivory = 'ivory'


class Animal(enum.Enum):
    Dog = 'dog'
    Snail = 'snail'
    Horse = 'horse'
    Fox = 'fox'
    Zebra = 'zebra'


class Drink(enum.Enum):
    Coffee = 'coffee'
    Tea = 'tea'
    Milk = 'milk'
    Oj = 'oj'
    Water = 'water'


class Hobby(enum.Enum):
    Dancing = 'dancing'
    Painting = 'painting'
    Football = 'football'
    Chess = 'chess'
    Reading = 'reading'


NUMBERS = set(range(0, 5))
NATIONALITIES = set(Nationality)
COLORS = set(Color)
ANIMALS = set(Animal)
DRINKS = set(Drink)
HOBBIES = set(Hobby)


house_constraints = [
    lambda h: (h.nationality == Nationality.Englishman) == (h.color == Color.Red),  # Rule 2
    lambda h: (h.nationality == Nationality.Spaniard) == (h.animal == Animal.Dog),  # Rule 3
    lambda h: (h.color == Color.Green) == (h.drink == Drink.Coffee),                # Rule 4
    lambda h: (h.nationality == Nationality.Ukrainian) == (h.drink == Drink.Tea),   # Rule 5
    lambda h: (h.animal == Animal.Snail) == (h.hobby == Hobby.Dancing),             # Rule 7
    lambda h: (h.color == Color.Yellow) == (h.hobby == Hobby.Painting),             # Rule 8
    lambda h: (h.number == 2) == (h.drink == Drink.Milk),                           # Rule 9
    lambda h: (h.nationality == Nationality.Norwegian) == (h.number == 0),          # Rule 10
    lambda h: (h.hobby == Hobby.Football) == (h.drink == Drink.Oj),                 # Rule 13
    lambda h: (h.nationality == Nationality.Japanese) == (h.hobby == Hobby.Chess),  # Rule 14
]


neighbor_constraints = [
    lambda h1, h2: (h1.color, h2.color) == (Color.Ivory, Color.Green),              # Rule 6
    lambda h1, h2: (
        (h1.hobby, h2.animal) == (Hobby.Reading, Animal.Fox) or 
        (h1.animal, h2.hobby) == (Animal.Fox, Hobby.Reading)
    ),                                                                              # Rule 11
    lambda h1, h2: (
        (h1.hobby, h2.animal) == (Hobby.Painting, Animal.Horse) or 
        (h1.animal, h2.hobby) == (Animal.Horse, Hobby.Painting)
    ),                                                                              # Rule 12
    lambda h1, h2: (
        (h1.nationality, h2.color) == (Nationality.Norwegian, Color.Blue) or 
        (h1.color, h2.nationality) == (Color.Blue, Nationality.Norwegian)
    ),                                                                              # Rule 15
]


def find_possible_houses():
    for number, nationality, color, animal, drink, hobby in product(
        NUMBERS, NATIONALITIES, COLORS, ANIMALS, DRINKS, HOBBIES
    ):
        candidate = Attributes(number, nationality, color, animal, drink, hobby)
        if all(constraint(candidate) for constraint in house_constraints):
            yield candidate


def build_tree(houses):
    tree = defaultdict(
        lambda: defaultdict(
            lambda: defaultdict(
                lambda: defaultdict(
                    lambda: defaultdict(
                        dict
                    )
                )
            )
        )
    )
    for h in houses:
        tree[h.number][h.nationality][h.color][h.animal][h.drink][h.hobby] = h
    return tree


def generate_permutations(tree1, tree2, tree3, tree4, tree5):
    for h1 in find_distinct_houses(tree1, {}):
        for h2 in find_distinct_houses(tree2, {h1}):
            for h3 in find_distinct_houses(tree3, {h1, h2}):
                for h4 in find_distinct_houses(tree4, {h1, h2, h3}):
                    for h5 in find_distinct_houses(tree5, {h1, h2, h3, h4}):
                        yield h1, h2, h3, h4, h5


def find_distinct_houses(tree, given_houses):
    used_nationalities = {h.nationality for h in given_houses}
    used_colors = {h.color for h in given_houses}
    used_animals = {h.animal for h in given_houses}
    used_drinks = {h.drink for h in given_houses}
    used_hobbies = {h.hobby for h in given_houses}

    for nationality, nationality_subtree in tree.items():
        if nationality not in used_nationalities:
            for color, color_subtree in nationality_subtree.items():
                if color not in used_colors:
                    for animal, animal_subtree in color_subtree.items():
                        if animal not in used_animals:
                            for drink, drink_subtree in animal_subtree.items():
                                if drink not in used_drinks:
                                    for hobby, house in drink_subtree.items():
                                        if hobby not in used_hobbies:
                                            yield house


def meets_street_constraints(street):
    return all(
        any(constraint(*neighbor_pair) for neighbor_pair in pairwise(street))
        for constraint in neighbor_constraints
    )


@cache
def find_solution():
    possible_houses_tree = build_tree(find_possible_houses())
    solutions = [
        street
        for street in generate_permutations(*possible_houses_tree.values())
        if meets_street_constraints(street)
    ]
    assert len(solutions) == 1
    return solutions[0]


def drinks_water():
    for house in find_solution():
        if house.drink == Drink.Water:
            return house.nationality.name


def owns_zebra():
    for house in find_solution():
        if house.animal == Animal.Zebra:
            return house.nationality.name
