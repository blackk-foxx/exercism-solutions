"""
    Simple Linked List solution
"""
from typing import Any, Optional


class EmptyListException(Exception):
    """
        Empty linked list exception.
    """
    def __init__(self) -> None:
        super().__init__("The list is empty.")


class Node:
    """
        List node. 
    """
    def __init__(self, value: Any, _next=None) -> None:
        self._value = value
        self._next = _next

    def value(self) -> Any:
        """
            Get the node value.
        """
        return self._value

    def next(self) -> "Node":
        """
            Get the next node.
        """
        return self._next


class LinkedList:
    """
        Singly linked list.
    """
    def __init__(self, values: Optional[list] = None):
        _next = None
        for v in values or []:
            _next = Node(v, _next)
        self._head = _next

    def __iter__(self):
        _next = self._head
        while _next:
            yield _next.value()
            _next = _next.next()

    def __len__(self):
        count = 0
        _next = self._head
        while _next:
            _next = _next.next()
            count += 1
        return count

    def head(self) -> Node:
        """
            Get the node at the beginning of the list.
        """
        if not self._head:
            raise EmptyListException
        return self._head

    def push(self, value: Any) -> None:
        """
            Prepend a value to the list.
        """
        self._head = Node(value, self._head)

    def pop(self) -> Any:
        """
            Remove the value at the beginning of the list.
        """
        if not self._head:
            raise EmptyListException
        node = self._head
        self._head = node.next()
        return node.value()

    def reversed(self) -> list[Any]:
        """
            Get the list values in reverse order.
        """
        return reversed(list(self))
