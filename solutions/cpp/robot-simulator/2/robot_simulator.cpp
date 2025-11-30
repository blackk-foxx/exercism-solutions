#include "robot_simulator.h"
#include <functional>
#include <map>

namespace robot_simulator {

void bump(Bearing& b, int n) {
    constexpr unsigned limit = static_cast<unsigned>(Bearing::COUNT);
    b = static_cast<Bearing>((static_cast<unsigned>(b) + n) % limit);
}

Robot::Robot(std::pair<int, int> position, Bearing bearing): 
    position(position), bearing(bearing) {
}

void Robot::turn_right() {
    bump(bearing, 1);
}

void Robot::turn_left() {
    bump(bearing, -1);
}

void Robot::advance() {
    static const std::map<Bearing, std::pair<int, int>> offsets_for_bearing = {
        {Bearing::NORTH, {0, 1}},
        {Bearing::EAST, {1, 0}},
        {Bearing::SOUTH, {0, -1}},
        {Bearing::WEST, {-1, 0}}
    };

    position.first += offsets_for_bearing.at(bearing).first;    
    position.second += offsets_for_bearing.at(bearing).second;
}    
    
void Robot::execute_sequence(const std::string& commands) {
    std::map<char, std::function<void()> > action_for_command {
        {'L', std::bind(&Robot::turn_left, this)}, 
        {'R', std::bind(&Robot::turn_right, this)}, 
        {'A', std::bind(&Robot::advance, this)}
    };
    for (auto c: commands)
        action_for_command.at(c)();
}

}  // namespace robot_simulator
