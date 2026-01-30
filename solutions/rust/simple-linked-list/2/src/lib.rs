struct ListNode<T> {
    value: T,
    next: ListNodePtr<T>
}

type ListNodePtr<T> = Option<Box<ListNode<T>>>;
    
impl<T> ListNode<T> {
    pub fn new(value: T) -> Self {
        Self {
            value,
            next: None
        }
    }

    pub fn count_at(node_ptr: &ListNodePtr<T>) -> usize {
        match node_ptr {
            Some(next_node) => 1 + next_node.count(),
            None => 0
        }
    }

    pub fn count(&self) -> usize {
        Self::count_at(&self.next)
    }

    pub fn push_onto(node_ptr: &mut ListNodePtr<T>, value: T) {
        match node_ptr {
            Some(next_node) => next_node.push(value),
            None => *node_ptr = Some(Box::new(ListNode::<T>::new(value)))
        }
    }

    pub fn push(&mut self, value: T) {
        Self::push_onto(&mut self.next, value)
    }

    fn pop_from(node_ptr: &mut ListNodePtr<T>) -> Option<T> {
        node_ptr.take().and_then(|mut node| {
            if node.next.is_some() {
                let result = node.pop();
                *node_ptr = Some(node);
                result
            }
            else {
                Some(node.value)
            }
        })
    }

    pub fn pop(&mut self) -> Option<T> {
        Self::pop_from(&mut self.next)
    }

    pub fn peek(&self) -> Option<&T> {
        match &self.next {
            Some(next_node) => next_node.peek(),
            None => Some(&self.value)
        }
    }
}

pub struct SimpleLinkedList<T> {
    head: ListNodePtr<T>
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self {
            head: None
        }
    }

    // You may be wondering why it's necessary to have is_empty()
    // when it can easily be determined from len().
    // It's good custom to have both because len() can be expensive for some types,
    // whereas is_empty() is almost always cheap.
    // (Also ask yourself whether len() is expensive for SimpleLinkedList)
    pub fn is_empty(&self) -> bool {
        self.head.is_none()
    }

    pub fn len(&self) -> usize {
        ListNode::<T>::count_at(&self.head)
    }

    pub fn push(&mut self, _element: T) {
        ListNode::<T>::push_onto(&mut self.head, _element);
    }

    pub fn pop(&mut self) -> Option<T> {
        ListNode::<T>::pop_from(&mut self.head)
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().and_then(|node| node.peek())
    }

    #[must_use]
    pub fn rev(mut self) -> SimpleLinkedList<T> {
        let mut result = SimpleLinkedList::<T>::new();
        while let Some(node) = self.pop() {
            result.push(node);
        }
        result
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(_iter: I) -> Self {
        _iter.into_iter().collect()
    }
}

// In general, it would be preferable to implement IntoIterator for SimpleLinkedList<T>
// instead of implementing an explicit conversion to a vector. This is because, together,
// FromIterator and IntoIterator enable conversion between arbitrary collections.
//
// The reason this exercise's API includes an explicit conversion to Vec<T> instead
// of IntoIterator is that implementing that interface is fairly complicated, and
// demands more of the student than we expect at this point in the track.
//
// Please note that the "front" of the linked list should correspond to the "back"
// of the vector as far as the tests are concerned.

impl<T> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut _linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut result = Vec::<T>::new();
        let mut maybe_node = _linked_list.head;
        while let Some(node) = maybe_node {
            result.push(node.value);
            maybe_node = node.next;
        }
        result
    }
}
