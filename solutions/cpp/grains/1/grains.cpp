#include "grains.h"

namespace grains {

unsigned long long square(int position) {
    return (long long)1 << (position - 1);
}

unsigned long long total() {
    unsigned long long result = 0;
    for (auto i = 1; i <= 64; i++)
        result += square(i);
    return result;
}

}  // namespace grains
