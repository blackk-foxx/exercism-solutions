class SgfTree:
    def __init__(self, properties=None, children=None):
        self.properties = properties or {}
        self.children = children or []

    def __eq__(self, other):
        if not isinstance(other, SgfTree):
            return False
        for key, value in self.properties.items():
            if key not in other.properties:
                return False
            if other.properties[key] != value:
                return False
        for key in other.properties.keys():
            if key not in self.properties:
                return False
        if len(self.children) != len(other.children):
            return False
        for child, other_child in zip(self.children, other.children):
            if child != other_child:
                return False
        return True

    def __ne__(self, other):
        return not self == other


def parse(input_string):
    return parse_tree(StringBuffer(input_string))


def parse_tree(buffer):
    buffer.consume("(", "tree missing")
    root_properties = parse_node(buffer)
    subtrees = []
    while buffer.peek() == "(":
        subtrees.append(parse_tree(buffer))
    child_lineage = []
    while buffer.peek() == ";":
        child_lineage.append(parse_node(buffer))
    buffer.consume(")")
    if child_lineage:
        subtrees += [link_lineage(child_lineage)]
    return SgfTree(properties=root_properties, children=subtrees)


def parse_node(buffer):
    buffer.consume(";", "tree with no nodes")
    properties = {}
    while buffer.peek().isalpha():
        key, value = parse_property(buffer)
        properties[key] = value
    return properties


def parse_property(buffer):
    key = parse_property_key(buffer)
    values = parse_property_values(buffer)
    if not values:
        raise ValueError("properties without delimiter")
    return "".join(key), values


def parse_property_key(buffer):
    key = []
    while buffer.peek().isalpha():
        if not buffer.peek().isupper():
            raise ValueError("property must be in uppercase")
        key.append(buffer.pop(0))
    return key


def parse_property_values(buffer):
    value_group = []
    while buffer.peek() == "[":
        buffer.pop(0)
        value = []
        while (next_char := buffer.pop(0)) != "]":
            if next_char == "\\":
                value.append(escape_value_char(buffer.pop(0)))
            else:
                value.append(normalize_value_char(next_char))
        value_group.append("".join(value))
    return value_group


def escape_value_char(char):
    if char == "\n":
        return ""
    return normalize_value_char(char)


def normalize_value_char(char):
    match char:
        case c if c == "\n":
            return "\n"
        case c if c.isspace():
            return " "
        case _:
            return char


def link_lineage(nodes):
    child = None
    for node in reversed(nodes):
        parent = SgfTree(properties=node, children=([child] if child else []))
        child = parent
    return child


class StringBuffer(list):

    def consume(self, expected, message=""):
        for c in expected:
            if len(self) == 0:
                raise ValueError(message)
            if self.pop(0) != c:
                raise ValueError(message)

    def peek(self):
        return self[0]
