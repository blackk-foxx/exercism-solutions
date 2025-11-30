#pragma once
#include <string>

namespace date_independent {

struct clock {
    int hour, minute;
    static clock at(int hour, int minute);
    clock plus(int minutes);
    explicit operator std::string() const;
    bool operator ==(const clock& other) const;
    bool operator !=(const clock& other) const;
};

}  // namespace date_independent
