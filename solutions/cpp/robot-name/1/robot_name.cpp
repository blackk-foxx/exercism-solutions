#include "robot_name.h"
#include <iomanip>
#include <random>
#include <sstream>

namespace robot_name {

robot::robot() {
    reset();
}

std::string generate_name() {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> alpha('A', 'Z');
    std::uniform_int_distribution<> numeric(0, 999);
    std::ostringstream result;
    result 
        << (char)alpha(gen)
        << (char)alpha(gen)
        << std::setw(3) << std::setfill('0') << numeric(gen);
    return result.str();
}

void robot::reset() {
    _name = generate_name();
    while (existing_names.find(_name) != existing_names.cend())
        _name = generate_name();
    existing_names.insert(_name);
}

std::unordered_set<std::string> robot::existing_names;

}  // namespace robot_name
