class EmptyListException(Exception):
    def __init__(self):
        super().__init__("The list is empty.")


class Node:
    def __init__(self, value, next=None):
        self._value = value
        self._next = next

    def value(self):
        return self._value

    def next(self):
        return self._next


class LinkedList:
    def __init__(self, values=None):
        next = None
        for v in values or []:
            next = Node(v, next)
        self._head = next

    def __iter__(self):
        next = self._head
        while next:
            yield next.value()
            next = next.next()

    def __len__(self):
        count = 0
        next = self._head
        while next:
            next = next.next()
            count += 1
        return count

    def head(self):
        if not self._head:
            raise EmptyListException
        return self._head

    def push(self, value):
        self._head = Node(value, self._head)

    def pop(self):
        if not self._head:
            raise EmptyListException
        node = self._head
        self._head = node.next()
        return node.value()

    def reversed(self):
        return reversed(list(self))
