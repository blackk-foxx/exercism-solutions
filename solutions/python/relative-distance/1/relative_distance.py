from collections import deque


class RelativeDistance:
    def __init__(self, family_tree):
        self.children_of = family_tree
        self.parent_of = {}
        for parent, children in family_tree.items():
            for child in children:
                self.parent_of[child] = parent

    def degree_of_separation(self, person_a, person_b):
        if not self.is_member(person_a):
            raise ValueError("Person A not in family tree.")
        if not self.is_member(person_b):
            raise ValueError("Person B not in family tree.")
        if path := self.find_shortest_path(person_a, person_b):
            return path.length()
        raise ValueError("No connection between person A and person B.")

    def is_member(self, person):
        return person in self.parent_of or person in self.children_of

    def find_shortest_path(self, person_a, person_b):
        # Breadth-first search
        queue = deque()
        explored = {person_a}
        queue.append(PathNode(person_a))
        while len(queue) > 0:
            next = queue.popleft()
            if next.name == person_b:
                return next
            for relative in self.get_immediate_relatives(next.name):
                if relative not in explored:
                    explored.add(relative)
                    queue.append(PathNode(name=relative, parent=next))
        return None
 
    def get_immediate_relatives(self, person):
        parent = self.parent_of.get(person)
        result = [parent] if parent else []
        result.extend(self.children_of.get(person, []))
        result.extend(self.get_siblings(person))
        return result
    
    def get_siblings(self, person):
        if parent := self.parent_of.get(person):
            return [c for c in self.children_of[parent] if c != person]
        return []


class PathNode:
    def __init__(self, name, parent=None):
        self.name = name
        self.parent = parent

    def length(self):
        if self.parent:
            return 1 + self.parent.length()
        else:
            return 0
