#include "binary_search.h"
#include <stdexcept>

std::size_t find_in_segment(const std::vector<int>& data, std::size_t begin, std::size_t end, int value) {
    auto midpoint = (begin + end) / 2;
    if (value == data.at(midpoint))
        return midpoint;
    if (midpoint == begin)
        throw std::domain_error("Not found");
    if (value < data.at(midpoint))
        return find_in_segment(data, begin, midpoint, value);
    return find_in_segment(data, midpoint, end, value);    
}

namespace binary_search {

std::size_t find(const std::vector<int>& data, int value) {
    if (data.size() == 0)
        throw std::domain_error("Not found");
    return find_in_segment(data, 0, data.size(), value);
}

}  // namespace binary_search
