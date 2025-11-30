from json import dumps
from collections import defaultdict


class Relations(defaultdict):
    def __init__(self, tree):
        super().__init__(set)
        self.walk(tree)

    def walk(self, tree):
        self[tree.label] |= set(c.label for c in tree.children)
        for c in tree.children:
            self[c.label].add(tree.label)
            self.walk(c)

    def build_pov_tree(self, label):
        links = self[label]
        self.unlink(label, links)
        children = [self.build_pov_tree(l) for l in links]
        return Tree(label, children)

    def find_path(self, from_node, to_node):
        links = self[from_node]
        self.unlink(from_node, links)
        for link in links:
            if link == to_node:
                return [from_node, to_node]
            else:
                if path := self.find_path(link, to_node):
                    return [from_node, *path]
        return None

    def unlink(self, label, links):
        for l in links:
            self[l].remove(label)



class Tree:
    def __init__(self, label, children=None):
        self.label = label
        self.children = children if children is not None else []

    def __dict__(self):
        return {self.label: [c.__dict__() for c in sorted(self.children)]}

    def __str__(self, indent=None):
        return dumps(self.__dict__(), indent=indent)

    def __lt__(self, other):
        return self.label < other.label

    def __eq__(self, other):
        return self.__dict__() == other.__dict__()

    def from_pov(self, from_node):
        relations = Relations(self)
        if from_node not in relations:
            raise ValueError("Tree could not be reoriented")
        return relations.build_pov_tree(from_node)

    def path_to(self, from_node, to_node):
        relations = Relations(self)
        if from_node not in relations:
            raise ValueError("Tree could not be reoriented")
        if to_node not in relations:
            raise ValueError("No path found")
        return relations.find_path(from_node, to_node)
