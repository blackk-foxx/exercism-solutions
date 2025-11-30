#include "nth_prime.h"
#include <algorithm>
#include <stdexcept>
#include <vector>

namespace nth_prime {

bool is_prime(unsigned int n, const std::vector<unsigned int> &known_primes) {
    std::vector<unsigned int> possible_divisors;
    std::copy_if(known_primes.cbegin(), known_primes.cend(),
                 std::back_inserter(possible_divisors),
                 [n](unsigned int p) { return p < n / 2; });
    return std::all_of(possible_divisors.cbegin(), possible_divisors.cend(), 
                       [n](unsigned int p) { return n % p != 0; });
}

unsigned int next_prime(const std::vector<unsigned int>& known_primes) {
    auto n = known_primes.back() + 2;
    while (!is_prime(n, known_primes))
        n += 2;
    return n;
}

std::vector<unsigned int> get_primes(unsigned int n) {
    if (n == 1)
        return {2};
    std::vector<unsigned int> result = {2, 3};
    while (result.size() < n)
        result.push_back(next_prime(result));
    return result;
}
    
unsigned int nth(unsigned int n) {
    if (n == 0)
        throw std::domain_error("Must be nonzero.");
    return get_primes(n).back();    
}

}  // namespace nth_prime
