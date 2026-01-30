pub struct SimpleLinkedList<T> {
    next: ListPtr<T>,
    value: T
}

type ListPtr<T> = Option<Box<SimpleLinkedList<T>>>;

impl<T: Default> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self {
            next: None,
            value: T::default()
        }
    }

    // You may be wondering why it's necessary to have is_empty()
    // when it can easily be determined from len().
    // It's good custom to have both because len() can be expensive for some types,
    // whereas is_empty() is almost always cheap.
    // (Also ask yourself whether len() is expensive for SimpleLinkedList)
    pub fn is_empty(&self) -> bool {
        self.next.is_none()
    }

    pub fn len(&self) -> usize {
        match &self.next {
            Some(next_node) => 1 + next_node.len(),
            None => 0
        }
    }

    pub fn push(&mut self, _element: T) {
        match &mut self.next {
            Some(next_node) => next_node.push(_element),
            None => self.next = Some(Box::new(Self {next:None, value: _element}))
        }
    }

    pub fn pop(&mut self) -> Option<T> {
        self.next.take().and_then(|mut node| {
            if node.next.is_some() {
                let result = node.pop();
                self.next = Some(node);
                result
            }
            else {
                Some(node.value)
            }
        })
    }

    pub fn peek(&self) -> Option<&T> {
        self.next.as_ref().and_then(|node| node.peek())
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

impl<T: Default> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut _linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut result = Vec::<T>::new();
        while let Some(value) = _linked_list.pop() {
            result.insert(0, value);
        }
        result
    }
}
