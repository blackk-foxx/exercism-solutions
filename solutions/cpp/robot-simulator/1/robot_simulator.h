#pragma once
#include <string>
#include <utility>

namespace robot_simulator {

typedef enum {
    NORTH = 0,
    EAST,
    SOUTH, 
    WEST
} Bearing;

class Robot {
public:
    Robot(std::pair<int, int> position = {0, 0}, Bearing bearing = NORTH);
    std::pair<int, int> get_position() const {return position;}
    Bearing get_bearing() const {return bearing;}
    void turn_right();
    void turn_left();
    void advance();
    void execute_sequence(const std::string& commands);
private:
    std::pair<int, int> position;
    Bearing bearing;
};

}  // namespace robot_simulator
