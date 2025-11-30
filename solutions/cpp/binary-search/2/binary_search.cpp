#include "binary_search.h"
#include <iostream>
#include <stdexcept>

namespace binary_search {

std::size_t find(const std::vector<int>& data, int value) {
    std::size_t begin = 0;
    std::size_t end = data.size();
    while (begin < end) {
        auto mid = (begin + end) / 2;
        auto value_at_mid = data[mid];
        if (value_at_mid == value) return mid;
        if (value > value_at_mid) begin = mid + 1;
        else end = mid;
    }
    throw std::domain_error("Not found");
}

}  // namespace binary_search
