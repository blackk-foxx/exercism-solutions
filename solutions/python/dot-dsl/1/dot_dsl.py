NODE, EDGE, ATTR = range(3)


class Node:
    def __init__(self, name, attrs):
        self.name = name
        self.attrs = attrs

    def __eq__(self, other):
        return self.name == other.name and self.attrs == other.attrs


class Edge:
    def __init__(self, src, dst, attrs):
        self.src = src
        self.dst = dst
        self.attrs = attrs

    def __eq__(self, other):
        return (self.src == other.src and
                self.dst == other.dst and
                self.attrs == other.attrs)


class Graph:
    def __init__(self, data=None):
        self.nodes = []
        self.edges = []
        self.attrs = {}
        data = data or []

        for entry in self.validate_data(data):
            kind, *args = self.validate_entry(entry)
            if kind == NODE:
                self.nodes.append(self.create_node(args))
            elif kind == EDGE:
                self.edges.append(self.create_edge(args))
            elif kind == ATTR:
                name, value = self.validate_attr(args)
                self.attrs[name] = value
            else:
                raise ValueError("Unknown item")

    @staticmethod
    def validate_data(data):
        try:
            yield from data
        except TypeError:
            raise TypeError("Graph data malformed")
        
    @staticmethod
    def validate_entry(entry):
        if not isinstance(entry, tuple):
            raise TypeError("Graph data malformed")
        try:
            kind, *args = entry
        except ValueError:
            raise TypeError("Graph item incomplete")
        return kind, *args

    @staticmethod
    def create_node(args):
        if len(args) != 2:
            raise ValueError("Node is malformed")
        return Node(*args)

    @staticmethod
    def create_edge(args):
        if len(args) != 3:
            raise ValueError("Edge is malformed")
        return Edge(*args)

    @staticmethod
    def validate_attr(args):
        if len(args) < 2:
            raise TypeError("Graph item incomplete")
        if len(args) > 2:
            raise ValueError("Attribute is malformed")
        return args


