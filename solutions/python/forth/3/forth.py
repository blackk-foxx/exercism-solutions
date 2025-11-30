import itertools
from functools import reduce


def divide(a, b):
    if a == 0:
        raise ZeroDivisionError("divide by zero")
    return [b // a]


BINARY_OPS = {
    '+': lambda a, b: [b + a],
    '-': lambda a, b: [b - a],
    '*': lambda a, b: [b * a],
    '/': divide,
    'swap': lambda a, b: [a, b],
    'over': lambda a, b: [b, a, b],
}


UNARY_OPS = {
    'dup': lambda a: [a, a],
    'drop': lambda a: [],
}

class StackUnderflowError(Exception):

    def __init__(self, message):
        self.message = message


def evaluate(input_data):
    return Evaluator(input_data).evaluate()


def parse_int(s):
    try:
        return int(s)
    except ValueError:
        return None

class Evaluator:

    def __init__(self, input_data):
        self.symbols = itertools.chain(*(i.split() for i in input_data))
        self.data = []
        self.user_defined_words = UserDefinitions()
        self.collecting_user_definition = False

    def evaluate(self):
        for symbol in self.symbols:
            self.evaluate_symbol(symbol.lower())
        return self.data

    def evaluate_symbol(self, symbol):
        if symbol == ":":
            self.start_collecting_user_definition()
        elif self.collecting_user_definition:
            self.handle_user_definition_collection(symbol)
        elif self.is_user_defined_word(symbol):
            self.evaluate_user_defined_word(symbol)
        elif self.is_literal(symbol):
            self.evaluate_literal(symbol)
        else:
            self.evaluate_op(symbol)

    def evaluate_op(self, op):
        if op in BINARY_OPS:
            self.evaluate_binary_op(op)
        elif op in UNARY_OPS:
            self.evaluate_unary_op(op)
        else:
            raise ValueError("undefined operation")

    def start_collecting_user_definition(self):
        self.collecting_user_definition = True
        self.user_defined_words.start_definition()

    def handle_user_definition_collection(self, symbol):
        if symbol != ";":
            self.user_defined_words.add_to_definition(symbol)
        else:
            self.user_defined_words.finish_definition()
            self.collecting_user_definition = False

    def is_user_defined_word(self, symbol):
        return symbol in self.user_defined_words

    def evaluate_user_defined_word(self, symbol):
        for sub_symbol in self.user_defined_words[symbol]:
            self.evaluate_symbol(sub_symbol)            

    @staticmethod
    def is_literal(symbol):
        return parse_int(symbol) is not None        

    def evaluate_literal(self, symbol):
        self.data.append(parse_int(symbol))

    def evaluate_unary_op(self, op):
        a, = self.pop_data(1)
        result = UNARY_OPS[op](a)
        self.data.extend(result)
        
    def evaluate_binary_op(self, op):
        a, b = self.pop_data(2)
        result = BINARY_OPS[op](a, b)
        self.data.extend(result)

    def pop_data(self, n):
        self.ensure_min_data_length(n)
        return [self.data.pop() for _ in range(n)]

    def ensure_min_data_length(self, n):
        if len(self.data) < n:
            raise StackUnderflowError("Insufficient number of items in stack")


class UserDefinitions(dict):

    def __init__(self):
        self.collecting = False
        self.definition = []

    def add_to_definition(self, symbol):
        if not self.definition:
            if parse_int(symbol) is not None:
                raise ValueError("illegal operation")
        self.definition.append(symbol)

    def start_definition(self):
        self.definition = []

    def finish_definition(self):
        name = self.definition[0]
        body = self.definition[1:]
        resolved_body = reduce(lambda a, word: a + self.get(word, [word]), body, [])
        self[name] = resolved_body
