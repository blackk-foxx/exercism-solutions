#include "sum_of_multiples.h"
#include <numeric>

namespace sum_of_multiples {

unsigned to(const std::unordered_set<unsigned>& factors, unsigned limit) {
    std::unordered_set<unsigned> multiples;
    for (auto f: factors)
        for (unsigned m = f; m < limit; m += f)
            multiples.insert(m);
    return std::accumulate(multiples.begin(), multiples.end(), 0);
}

}  // namespace sum_of_multiples
