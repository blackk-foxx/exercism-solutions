class Zipper:

    def __init__(self, tree, focus, parent=None):
        self.tree = tree
        self.focus = focus
        self.parent = parent

    @staticmethod
    def from_tree(tree):
        return Zipper(tree, tree)

    def value(self):
        return self.focus["value"]

    def set_value(self, value):
        self.focus["value"] = value
        return self

    def left(self):
        return self._child("left")

    def set_left(self, tree):
        self.focus["left"] = tree
        return self

    def right(self):
        return self._child("right")

    def set_right(self, tree):
        self.focus["right"] = tree
        return self

    def up(self):
        return self.parent

    def to_tree(self):
        return self.tree

    def _child(self, position):
        if focus := self.focus[position]:
            return Zipper(self.tree, focus, self)
        return None
