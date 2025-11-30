import itertools


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
        self.current_user_definition = []
        self.user_defined_words = {}
        self.collecting_user_definition = False

    def evaluate(self):
        for symbol in self.symbols:
            self.evaluate_symbol(symbol.lower())
        return self.data

    def evaluate_symbol(self, symbol):
        if self.collecting_user_definition:
            if not self.current_user_definition:
                if parse_int(symbol) is not None:
                    raise ValueError("illegal operation")
            if symbol != ";":
                self.current_user_definition.append(symbol)
            else:
                self.add_user_definition()
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
        elif symbol == ":":
            self.collecting_user_definition = True
            self.current_user_definition = []
        else:
            raise ValueError("undefined operation")

    def add_user_definition(self):
        name = self.current_user_definition[0]
        body = self.current_user_definition[1:]
        resolved_body = []
        for word in body:
            if word in self.user_defined_words:
                resolved_body += self.user_defined_words[word]
            else:
                resolved_body += [word]
        self.user_defined_words[name] = resolved_body
        
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
