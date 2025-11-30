#include "prime_factors.h"

namespace prime_factors {

std::vector<long long> of(long long n) {
    std::vector<long long> result;
    while (n % 2 == 0) {
        result.push_back(2);
        n /= 2;
    }
    for (long long f = 3; f <= n; f += 2) {
        while (n % f == 0) {
            result.push_back(f);
            n /= f;
        } 
    }
    return result;
}

}  // namespace prime_factors
