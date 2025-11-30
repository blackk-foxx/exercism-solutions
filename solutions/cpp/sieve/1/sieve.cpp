#include "sieve.h"
#include <algorithm>
#include <set>

namespace sieve {

std::vector<int> primes(int n) {
    if (n < 2) return {};
    std::set<int> candidates;
    std::set<int> not_prime;
    for (auto m = 2; m <= n; m++)
        candidates.insert(m);
    for (auto x: candidates) {
        if (not_prime.find(x) != not_prime.end()) continue;
        for (auto y = 2; y * x <= n; y++) {
            not_prime.insert(y * x);
        }
    }
    std::vector<int> diff;
    std::set_difference(
        candidates.cbegin(), candidates.cend(), 
        not_prime.cbegin(), not_prime.cend(), 
        std::back_inserter(diff)
    );
    return diff;
}

}  // namespace sieve
