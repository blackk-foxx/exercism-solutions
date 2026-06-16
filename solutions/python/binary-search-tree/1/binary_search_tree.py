class TreeNode:
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return f'TreeNode(data={self.data}, left={self.left}, right={self.right})'

    def insert(self, value):
        if value <= self.data:
            if self.left:
                self.left.insert(value)
            else:
                self.left = TreeNode(value)
        else:
            if self.right:
                self.right.insert(value)
            else:
                self.right = TreeNode(value)

    def walk(self):
        return (self.left.walk() if self.left else []) + [self.data] + (self.right.walk() if self.right else [])

class BinarySearchTree:
    def __init__(self, tree_data):
        self.root = TreeNode(tree_data[0])
        for value in tree_data[1:]:
            self.root.insert(value)

    def data(self):
        return self.root

    def sorted_data(self):
        return self.root.walk()
