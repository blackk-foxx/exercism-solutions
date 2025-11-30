#include "triangle.h"
#include <stdexcept>

namespace triangle {

void validate(float a, float b, float c) {
    if ((a + b < c) || (b + c < a) || (a + c < b))
        throw std::domain_error("Invalid triangle");
    if ((a == 0) && (b == 0) && (c == 0))
        throw std::domain_error("Invalid triangle");
}

flavor kind(float a, float b, float c) {
    validate(a, b, c);
    if ((a == b) && (b == c) && (a == c))
        return flavor::equilateral;
    if ((a == b) || (b == c) || (a == c))
        return flavor::isosceles;
    return flavor::scalene;
}

}  // namespace triangle
