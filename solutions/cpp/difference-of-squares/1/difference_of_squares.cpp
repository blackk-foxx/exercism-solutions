#include "difference_of_squares.h"

namespace difference_of_squares {

unsigned int sum(unsigned int n) {
    if (n == 1) return 1;
    else return n + sum(n - 1);
}

unsigned int square_of_sum(unsigned int n) {
    auto s = sum(n);
    return s * s;    
}

unsigned int sum_of_squares(unsigned int n) {
    if (n == 1) return 1;
    else return n * n + sum_of_squares(n - 1);
}

unsigned int difference(unsigned int n) {
    return square_of_sum(n) - sum_of_squares(n);
}

}  // namespace difference_of_squares
