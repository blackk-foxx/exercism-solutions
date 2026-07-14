import enum
from collections import defaultdict, namedtuple
from collections.abc import Callable, Iterable, Iterator, Mapping
from functools import cache
from itertools import product, pairwise
from typing import Any, TypeAlias, TypeVar

House = namedtuple('House', ['number', 'nationality', 'color', 'animal', 'drink', 'hobby'])


class Nationality(enum.Enum):
    englishman = 'Englishman'
    spaniard = 'Spaniard'
    ukrainian = 'Ukrainian'
    norwegian = 'Norwegian'
    japanese = 'Japanese'


class Color(enum.Enum):
    red = 'red'
    yellow = 'yellow'
    green = 'green'
    blue = 'blue'
    ivory = 'ivory'


class Animal(enum.Enum):
    dog = 'dog'
    snail = 'snail'
    horse = 'horse'
    fox = 'fox'
    zebra = 'zebra'


class Drink(enum.Enum):
    coffee = 'coffee'
    tea = 'tea'
    milk = 'milk'
    orange_juice = 'orange juice'
    water = 'water'


class Hobby(enum.Enum):
    dancing = 'dancing'
    painting = 'painting'
    football = 'football'
    chess = 'chess'
    reading = 'reading'


Street: TypeAlias = tuple[House, House, House, House, House]
TreeKey: TypeAlias = int | Nationality | Color | Animal | Drink | Hobby
NationalityTree = dict[Nationality, dict[Color, dict[Animal, dict[Drink, dict[Hobby, House]]]]]
HouseTree: TypeAlias = dict[int, NationalityTree]
K = TypeVar("K")

NUMBERS = set(range(0, 5))
NATIONALITIES = set(Nationality)
COLORS = set(Color)
ANIMALS = set(Animal)
DRINKS = set(Drink)
HOBBIES = set(Hobby)


house_constraints: list[Callable[[House], bool]] = [
    lambda h: (h.nationality == Nationality.englishman) == (h.color == Color.red),  # Rule 2
    lambda h: (h.nationality == Nationality.spaniard) == (h.animal == Animal.dog),  # Rule 3
    lambda h: (h.color == Color.green) == (h.drink == Drink.coffee),                # Rule 4
    lambda h: (h.nationality == Nationality.ukrainian) == (h.drink == Drink.tea),   # Rule 5
    lambda h: (h.animal == Animal.snail) == (h.hobby == Hobby.dancing),             # Rule 7
    lambda h: (h.color == Color.yellow) == (h.hobby == Hobby.painting),             # Rule 8
    lambda h: (h.number == 2) == (h.drink == Drink.milk),                           # Rule 9
    lambda h: (h.nationality == Nationality.norwegian) == (h.number == 0),          # Rule 10
    lambda h: (h.hobby == Hobby.football) == (h.drink == Drink.orange_juice),       # Rule 13
    lambda h: (h.nationality == Nationality.japanese) == (h.hobby == Hobby.chess),  # Rule 14
]


neighbor_constraints: list[Callable[[House, House], bool]] = [
    lambda h1, h2: (h1.color, h2.color) == (Color.ivory, Color.green),              # Rule 6
    lambda h1, h2: (
        (h1.hobby, h2.animal) == (Hobby.reading, Animal.fox) or 
        (h1.animal, h2.hobby) == (Animal.fox, Hobby.reading)
    ),                                                                              # Rule 11
    lambda h1, h2: (
        (h1.hobby, h2.animal) == (Hobby.painting, Animal.horse) or 
        (h1.animal, h2.hobby) == (Animal.horse, Hobby.painting)
    ),                                                                              # Rule 12
    lambda h1, h2: (
        (h1.nationality, h2.color) == (Nationality.norwegian, Color.blue) or 
        (h1.color, h2.nationality) == (Color.blue, Nationality.norwegian)
    ),                                                                              # Rule 15
]


def find_possible_houses() -> Iterator[House]:
    """
    Iterate over the subset of houses that meet all the constraints in house_constraints.
    """
    for number, nationality, color, animal, drink, hobby in product(
        NUMBERS, NATIONALITIES, COLORS, ANIMALS, DRINKS, HOBBIES
    ):
        candidate = House(number, nationality, color, animal, drink, hobby)
        if all(constraint(candidate) for constraint in house_constraints):
            yield candidate


def make_recursive_defaultdict() -> dict:
    return defaultdict(make_recursive_defaultdict)


def build_tree(houses: Iterable[House]) -> HouseTree:
    """
    Build a search tree from the given iterable of houses.  Each level of the tree
    represents a different house attribute.  For example, the first level represents
    the housse number.  The tree is implemented as a dict whose keys are the values
    of the attribute for the given level and whose values are either subtrees (i.e. 
    branch nodes) or houses (i.e. leaf nodes).
    """
    tree = make_recursive_defaultdict()
    for h in houses:
        tree[h.number][h.nationality][h.color][h.animal][h.drink][h.hobby] = h
    return tree


def pruned(tree: dict[K, Any], excluded_keys: set[K]) -> Iterator:
    """
    Iterate over the child nodes of `tree` whose keys are not in `excluded_keys`. Note that
    the child nodes can be subtrees (i.e. branch nodes) or Houses (i.e. leaf nodes).
    """
    for key, value in tree.items():
        if key not in excluded_keys:
            yield value


def find_distinct_houses(tree: NationalityTree, established_houses: Iterable[House]) -> Iterator[House]:
    """
    Iterate over the houses in `tree` that are distinct from all (i.e. share no attributes 
    with any) of the houses in `established_houses`.
    """
    taken_nationalities = {h.nationality for h in established_houses}
    taken_colors = {h.color for h in established_houses}
    taken_animals = {h.animal for h in established_houses}
    taken_drinks = {h.drink for h in established_houses}
    taken_hobbies = {h.hobby for h in established_houses}

    for nationality_subtree in pruned(tree, taken_nationalities):
        for color_subtree in pruned(nationality_subtree, taken_colors):
            for animal_subtree in pruned(color_subtree, taken_animals):
                for drink_subtree in pruned(animal_subtree, taken_drinks):
                    for house in pruned(drink_subtree, taken_hobbies):
                        yield house


def generate_permutations(tree: HouseTree) -> Iterator[Street]:
    """
    Iterate over the distinct permutations (i.e. streets) in the given tree.
    """
    tree1, tree2, tree3, tree4, tree5 = list(tree.values())
    for h1 in find_distinct_houses(tree1, {}):
        for h2 in find_distinct_houses(tree2, {h1}):
            for h3 in find_distinct_houses(tree3, {h1, h2}):
                for h4 in find_distinct_houses(tree4, {h1, h2, h3}):
                    for h5 in find_distinct_houses(tree5, {h1, h2, h3, h4}):
                        yield h1, h2, h3, h4, h5


def meets_street_constraints(street: Street) -> bool:
    """
    Indicate whether the neighbor pairings in the given street meet all of the 
    constraints in `neighbor_constraints`.
    """
    return all(
        any(constraint(*neighbor_pair) for neighbor_pair in pairwise(street))
        for constraint in neighbor_constraints
    )


@cache
def find_solution() -> Street:
    """
    Find the solution, i.e. the one possible permutation that meets all of the
    constraints in `house_constraints` and `neighbor_constraints`.
    """
    possible_houses_tree = build_tree(find_possible_houses())
    solutions = [
        street
        for street in generate_permutations(possible_houses_tree)
        if meets_street_constraints(street)
    ]
    assert len(solutions) == 1
    return solutions[0]


def drinks_water() -> str | None:
    """
    Return the nationality of the house owner who drinks water.
    """
    for house in find_solution():
        if house.drink == Drink.water:
            return house.nationality.value
    return None


def owns_zebra() -> str | None:
    """
    Return the nationality of the house owner who owns the zebra.
    """
    for house in find_solution():
        if house.animal == Animal.zebra:
            return house.nationality.value
    return None
