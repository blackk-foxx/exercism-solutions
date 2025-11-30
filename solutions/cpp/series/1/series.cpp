#include "series.h"
#include <stdexcept>

void validate(std::string_view digits, size_t length) {
    if (length > digits.size()) throw std::domain_error("Length too large");
    if (length == 0) throw std::domain_error("Length cannot be zero");
}

namespace series {

std::vector<std::string> slice(std::string_view digits, size_t length) {
    validate(digits, length);
    std::vector<std::string> result;
    for (size_t i = 0; i <= digits.size() - length; i++)
        result.push_back(std::string(digits.substr(i, length)));
    return result;
}

}  // namespace series
