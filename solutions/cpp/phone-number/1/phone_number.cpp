#include "phone_number.h"
#include <algorithm>
#include <stdexcept>

bool is_num(char c) {
    return ('0' <= c && c <= '9');
}

void validate(std::string_view digits) {
    if (digits.size() < 10) throw std::domain_error("Too short");
    if (digits.size() > 11) throw std::domain_error("Too long");
    if (digits.size() == 11 && digits.at(0) != '1')
        throw std::domain_error("Must start with 1");
}

void validate_initial_digit(char digit, const std::string& msg_prefix) {
    if (digit < '2')
        throw std::domain_error(msg_prefix + " must start with digit >= 2");
}

namespace phone_number {

phone_number::phone_number(std::string_view text) {
    std::copy_if(text.begin(), text.end(), std::back_inserter(digits), is_num);
    validate(digits);
    if (digits.size() == 11) digits = digits.substr(1);
    validate_initial_digit(digits.at(0), "Area code");
    validate_initial_digit(digits.at(3), "Exchange code");
}

}  // namespace phone_number
