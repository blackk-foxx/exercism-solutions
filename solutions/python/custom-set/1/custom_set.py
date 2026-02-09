class CustomSet:
    def __init__(self, elements=[]):
        self.elements = []
        for e in elements:
            self.add(e)

    def isempty(self):
        return len(self.elements) == 0

    def __contains__(self, element):
        return element in self.elements

    def issubset(self, other):
        return all(e in other for e in self.elements)

    def isdisjoint(self, other):
        return len(self.intersection(other).elements) == 0

    def __eq__(self, other):
        return sorted(self.elements) == sorted(other.elements)

    def add(self, element):
        if element not in self.elements:
            self.elements.append(element)

    def intersection(self, other):
        return CustomSet([
            e for e in other.elements if e in self.elements
        ])

    def __sub__(self, other):
        return CustomSet([
            e for e in self.elements
            if e not in other.elements
        ])

    def __add__(self, other):
        return CustomSet(self.elements + other.elements)
