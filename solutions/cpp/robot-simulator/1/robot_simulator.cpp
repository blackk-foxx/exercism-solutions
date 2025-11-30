#include "robot_simulator.h"
#include <map>

namespace robot_simulator {

Robot::Robot(std::pair<int, int> position, Bearing bearing): position(position), bearing(bearing) {
    
}

void Robot::turn_right() {
    bearing = bearing == WEST ? NORTH : (Bearing) ((int) bearing + 1);
}

void Robot::turn_left() {
    bearing = bearing == NORTH ? WEST : (Bearing) ((int) bearing - 1);
}

void Robot::advance() {
    static const std::map<Bearing, std::pair<int, int>> offsets_for_bearing = {
        {NORTH, {0, 1}},
        {EAST, {1, 0}},
        {SOUTH, {0, -1}},
        {WEST, {-1, 0}}
    };

    position.first += offsets_for_bearing.at(bearing).first;    
    position.second += offsets_for_bearing.at(bearing).second;    
}    
    
void Robot::execute_sequence(const std::string& commands) {
    for (auto c: commands) {
        switch(c) {
            case 'L': 
                turn_left();
                break;
            case 'R':
                turn_right();
                break;
            case 'A':
                advance();
                break;
        }
    }
}

}  // namespace robot_simulator
