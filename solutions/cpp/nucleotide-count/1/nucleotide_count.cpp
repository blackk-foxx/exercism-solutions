#include "nucleotide_count.h"
#include <stdexcept>

namespace nucleotide_count {

std::map<char, int> count(const char* strand) {
    std::map<char, int> result = {{'A', 0}, {'C', 0}, {'G', 0}, {'T', 0}};
    for (auto c = strand; *c != 0; c++) {
        if (result.find(*c) == result.end())
            throw std::invalid_argument("Invalid strand");
        result[*c] += 1;
    }
    return result;
}

}  // namespace nucleotide_count
