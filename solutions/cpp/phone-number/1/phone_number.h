#pragma once
#include <string>

namespace phone_number {

struct phone_number {
    phone_number(std::string_view text);
    const std::string& number() const {return digits;};
    std::string digits;
};

}  // namespace phone_number
