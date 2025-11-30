class Node:
    def __init__(self, value: int, succeeding: 'Node' = None, previous: 'Node' = None):
        self.value = value
        self.succeeding = succeeding
        self.previous = previous

    def __repr__(self):
        return f"{self.value}"


class LinkedList:
    def __init__(self):
        self.head_node = Node(0)
        self.tail_node = Node(0)
        self.head_node.succeeding = self.tail_node
        self.tail_node.previous = self.head_node
        self.count = 0

    def __len__(self):
        return self.count

    def push(self, value: int) -> None:
        previous = self.tail_node.previous
        node = Node(value, previous=previous, succeeding=self.tail_node)
        previous.succeeding = node
        self.tail_node.previous = node
        self.count += 1

    def unshift(self, value: int) -> None:
        succeeding = self.head_node.succeeding
        node = Node(value, previous=self.head_node, succeeding=succeeding)
        succeeding.previous = node
        self.head_node.succeeding = node
        self.count += 1

    def pop(self) -> int:
        if self.count == 0:
            raise IndexError("List is empty")
        node = self.tail_node.previous
        self.remove(node)
        return node.value

    def shift(self) -> int:
        if self.count == 0:
            raise IndexError("List is empty")
        node = self.head_node.succeeding
        self.remove(node)
        return node.value

    def delete(self, value) -> None:
        if not (node := self.find(value)):
            raise ValueError("Value not found")
        self.remove(node)

    def remove(self, node) -> None:
        previous = node.previous
        succeeding = node.succeeding
        previous.succeeding = succeeding
        succeeding.previous = previous
        self.count -= 1

    def find(self, value) -> Node:
        node = self.head_node.succeeding
        while node != self.tail_node:
            if node.value == value:
                return node
            node = node.succeeding
        return None
            
            