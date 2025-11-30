#include "say.h"
#include <array>
#include <cmath>
#include <stdexcept>
#include <string>

namespace say {

const std::string ones_and_teens[] = {
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
};

const std::string tens[] = {
    "",
    "ten",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety"
};

const std::string powers[] = {
    "",
    "thousand",
    "million",
    "billion"
};

std::string tail(unsigned long int remainder, const std::string& separator) {
    if (remainder)
        return separator + in_english(remainder);
    return "";
}

std::string large_n_in_english(long int n, long int divisor, const std::string& qualifier) {
    auto quantity = n / divisor;
    auto remainder = n % divisor;
    return in_english(quantity) + " " + qualifier + tail(remainder, " ");
}

std::string very_large_n_in_english(long int n) {
    unsigned int magnitude = log10(n)/3;
    if (magnitude < sizeof(powers)/sizeof(powers[0]))
        return large_n_in_english(n, pow(1000, magnitude), powers[magnitude]);
    throw std::domain_error("Out of range.");    
}

std::string in_english(long int n) {
    if (n < 0)
        throw std::domain_error("Must not be negative.");
    if (n < 20)
        return ones_and_teens[n];
    if (n < 100) 
        return tens[n / 10] + tail(n % 10, "-");
    if (n < 1000)
        return large_n_in_english(n, 100, "hundred");
    return very_large_n_in_english(n);
}

}  // namespace say
