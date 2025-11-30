type NodeRef<TElement> = Node<TElement> | undefined;

class Node<TElement> {

  value: TElement;
  next: NodeRef<TElement>;
  prev: NodeRef<TElement>;

  constructor (value: TElement) {
    this.value = value;
    this.next = undefined;
    this.prev = undefined;
  }
}

export class LinkedList<TElement> {

  head: NodeRef<TElement> = undefined;
  tail: NodeRef<TElement> = undefined;
  
  public push(element: TElement) {
    let node = new Node(element);
    let tail = this.tail;
    if (tail) {
      tail.next = node;
      node.prev = tail;
    }
    else {
      this.head = node;
    }
    this.tail = node;
  }

  public pop(): TElement {
    let tail = this.tail;
    if (tail) {
      this.#remove(tail);
      return tail.value;
    }
    throw new Error('List is empty');
  }

  public shift(): TElement {
    let head = this.head;
    if (head) {
      this.#remove(head);
      return head.value;
    }
    throw new Error('List is empty');
  }

  public unshift(element: TElement) {
    let node = new Node(element);
    let head = this.head;
    if (head) {
      head.prev = node;
      node.next = head;
    }
    else {
      this.tail = node;
    }
    this.head = node;
  }

  public delete(element: TElement) {
    let node = this.#find(element);
    if (node)
      this.#remove(node);
  }

  #find(element: TElement): NodeRef<TElement> {
    let node = this.head;
    while (node) {
      if (node.value == element)
        return node;
      node = node.next;
    }
    return undefined;
  }

  #remove(node: Node<TElement>) {
    let next = node.next;
    let prev = node.prev;
    if (prev)
      prev.next = next;
    if (next)
      next.prev = prev;
    if (this.head == node)
      this.head = next;
    if (this.tail == node)
      this.tail = prev;
  }

  public count(): number {
    let result = 0;
    let node = this.head;
    while (node) {
      result++;
      node = node.next;
    }
    return result;
  }
}
