from collections import deque, defaultdict

class GraphNode:
    def __init__(self):
        self.edges = set()

    def add_edge(self, name):
        self.edges.add(name)

    def add_edges(self, others):
        for other in others:
            self.add_edge(other)
        

class PathNode:
    def __init__(self, name, parent=None):
        self.name = name
        self.parent = parent

    def length(self):
        if self.parent:
            return 1 + self.parent.length()
        else:
            return 0

class RelativeDistance:
    def __init__(self, family_tree):
        self.nodes = defaultdict(GraphNode)
        for parent, children in family_tree.items():
            for child in children:
                self.nodes[parent].add_edge(child)
                self.nodes[child].add_edge(parent)
                self.nodes[child].add_edges(children)

    def degree_of_separation(self, person_a, person_b):
        if person_a not in self.nodes:
            raise ValueError("Person A not in family tree.")
        if person_b not in self.nodes:
            raise ValueError("Person B not in family tree.")
        if path := self.shortest_path(person_a, person_b):
            return path.length()
        raise ValueError("No connection between person A and person B.")

    def shortest_path(self, person_a, person_b):
        q = deque()
        explored = {person_a}
        q.append(PathNode(person_a))
        while len(q) > 0:
            v = q.popleft()
            if v.name == person_b:
                return v
            for edge in self.nodes[v.name].edges:
                if edge not in explored:
                    explored.add(edge)
                    q.append(PathNode(name=edge, parent=v))
        return None
