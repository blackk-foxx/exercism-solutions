#pragma once
#include <memory>
#include <vector>

namespace binary_search_tree {

template <typename T> struct binary_tree {

    using tree_ptr = typename std::unique_ptr<binary_tree<T>>;

    struct iterator {

        iterator(binary_tree& root) {
            position = 0;
            walk(root);
        }

        void advance_to_end() {
            position = data.size();
        }

        bool operator != (iterator& other) {
            return position != other.position;
        }

        void operator ++ () {
            position++;
        }

        T& operator * () {
            return data[position];
        }

        void walk(binary_tree& node) {
            if (node.left())
                walk(*node.left());
            data.push_back(node.data());
            if (node.right())
                walk(*node.right());
        }
        std::vector<T> data;
        std::size_t position;
    };
    
    binary_tree(T value) {
        _value = value;
    }

    iterator begin() {
        return iterator(*this);
    }

    iterator end() {
        auto result = iterator(*this);
        result.advance_to_end();
        return result;
    }

    void insert(T value) {
        if (value <= _value) {
            if (_left)
                _left->insert(value);
            else
                _left.reset(new binary_tree(value));
        }
        else {
            if (_right)
                _right->insert(value);
            else
                _right.reset(new binary_tree(value));
        }
    }

    T data() {
        return _value;
    }

    tree_ptr& left() {
        return _left;
    }

    tree_ptr& right() {
        return _right;
    }

    tree_ptr _left;
    tree_ptr _right;
    T _value;
    
};

template <typename T> typename binary_tree<T>::iterator begin(binary_tree<T>& tree) {
    return tree.begin();
}

template <typename T> typename binary_tree<T>::iterator end(binary_tree<T>& tree) {
    return tree.end();
}
    
}  // namespace binary_search_tree
