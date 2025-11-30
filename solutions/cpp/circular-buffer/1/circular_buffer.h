#pragma once
#include <cstddef>
#include <stdexcept>
#include <vector>

namespace circular_buffer {

template <typename T> struct circular_buffer {
    circular_buffer(std::size_t size) {
        items.resize(size);
        clear();
    }

    T read() {
        if (size == 0)
            throw std::domain_error("buffer is empty");
        T result = *head;
        bump(head);
        size--;
        return result;
    }
    
    void write(T value) {
        if (size == items.size())
            throw std::domain_error("buffer is full");
        *tail = value;
        bump(tail);
        size++;
    }

    void overwrite(T value) {
        *tail = value;
        bump(tail);
        if (size < items.size())
            size++;
        else
            bump(head);
    }

    void clear() {
        size = 0;
        head = items.begin();
        tail = items.begin();
    }

private:
    void bump(typename std::vector<T>::iterator& iter) {
        iter++;
        if (iter == items.end())
            iter = items.begin();
    }

    typename std::vector<T> items;
    typename std::vector<T>::iterator head, tail;
    size_t size;
};
    
}  // namespace circular_buffer
