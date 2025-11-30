#include "sieve.h"
#include <algorithm>
#include <set>

namespace sieve {

std::vector<int> primes(int n) {
    if (n < 2) return {};
    std::set<int> candidates;
    for (auto m = 2; m <= n; m++)
        candidates.insert(m);
    for (auto x: candidates)
        for (auto y = 2; y * x <= n; y++)
            if (candidates.find(y * x) != candidates.end())
                candidates.erase(y * x);
    return std::vector<int>(candidates.cbegin(), candidates.cend());
}

}  // namespace sieve
