#include "trinary.h"
#include <algorithm>
#include <cmath>

bool is_valid(std::string_view trinary) {
    return std::all_of(trinary.begin(), trinary.end(), 
        [](char c) {return ('0' <= c && c <= '2');});
}

namespace trinary {

unsigned to_decimal(std::string_view trinary) {
    if (!is_valid(trinary)) return 0;
    unsigned result = 0;
    for (auto it = trinary.rbegin(); it != trinary.rend(); ++it)
        result += (*it - '0') * pow(3, it - trinary.rbegin());
    return result;
}
    
}  // namespace trinary
