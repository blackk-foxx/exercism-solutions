import itertools
from functools import reduce


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
            self.collecting_user_definition = True
            self.user_defined_words.start_definition()
        elif self.collecting_user_definition:
            if symbol != ";":
                self.user_defined_words.add_to_definition(symbol)
            else:
                self.user_defined_words.finish_definition()
                self.collecting_user_definition = False
        elif symbol in self.user_defined_words:
            for sub_symbol in self.user_defined_words[symbol]:
                self.evaluate_symbol(sub_symbol)            
        elif (v := parse_int(symbol)) is not None:
            self.data.append(v)
        elif symbol in {"+", "-", "*", "/", "swap", "over"}:
            self.evaluate_binary_op(symbol)
        elif symbol in {"dup", "drop"}:
            self.evaluate_unary_op(symbol)
        else:
            raise ValueError("undefined operation")

    def add_user_definition(self, name, body):
        self.user_defined_words[name] = body
        
    def evaluate_unary_op(self, op):
        self.ensure_min_data_length(1)
        match op:
            case "dup":
                self.data.append(self.data[-1])
            case "drop":
                self.data.pop()
        
    def evaluate_binary_op(self, op):
        a, b = self.pop_data(2)
        match op:
            case '+':
                self.data.append(b + a)
            case '-':
                self.data.append(b - a)
            case '*':
                self.data.append(b * a)
            case '/':
                if a == 0:
                    raise ZeroDivisionError("divide by zero")
                self.data.append(b // a)
            case "swap":
                self.data += [a, b]
            case "over":
                self.data += [b, a, b]

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
