#include "hamming.h"
#include <cstring>
#include <stdexcept>

namespace hamming {

unsigned compute(const char* a, const char* b) {
    if (strlen(a) != strlen(b))
        throw std::domain_error("Must be equal length");
    unsigned result = 0;
    for (; *a != 0 && *b != 0; ++a, ++b)
        result += (*a == *b) ? 0 : 1;
    return result;
}

}  // namespace hamming
