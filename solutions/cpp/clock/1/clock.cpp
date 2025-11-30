#include "clock.h"
#include <iomanip>
#include <sstream>

namespace date_independent {

clock clock::at(int hour, int minute) {
    constexpr int MINUTES_PER_HOUR = 60;
    constexpr int HOURS_PER_DAY = 24;
    hour = (hour + minute / MINUTES_PER_HOUR) % HOURS_PER_DAY;
    minute = minute % MINUTES_PER_HOUR;
    if (minute < 0) {
        hour--;
        minute += MINUTES_PER_HOUR;
    }
    if (hour < 0) hour += HOURS_PER_DAY;
    return {hour, minute};
}
    
clock clock::plus(int minutes) {
    return at(hour, this->minute + minutes);
}

static std::string format(int n) {
    std::ostringstream result;
    result << std::setw(2) << std::setfill('0') << n;
    return result.str();
}

clock::operator std::string() const {
    return format(hour) + ":" + format(minute);
}
    
bool clock::operator ==(const clock& other) const {
    return this->hour == other.hour && this->minute == other.minute;
}

bool clock::operator !=(const clock& other) const {
    return !(*this == other);
}

}  // namespace date_independent
