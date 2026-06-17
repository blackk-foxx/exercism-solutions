"""
    Binary search tree exercise solution
"""

class TreeNode:
    """
        A node in a tree.  Each node can be treated as a subtree.
    """
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return f'TreeNode(data={self.data}, left={self.left}, right={self.right})'

    def insert(self, value):
        """
            Insert a value into the tree.
        """
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
        """
            Traverse the tree in order.
        """
        left = self.left.walk() if self.left else []
        right = self.right.walk() if self.right else []
        return [*left, self.data, *right]


class BinarySearchTree:
    """
        A binary search tree
    """
    def __init__(self, tree_data):
        self.root = TreeNode(tree_data[0])
        for value in tree_data[1:]:
            self.root.insert(value)

    def data(self):
        """
            Return the raw tree.
        """
        return self.root

    def sorted_data(self):
        """
            Return the sorted data in the tree.
        """
        return self.root.walk()
