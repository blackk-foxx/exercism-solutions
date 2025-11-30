#include <string>
#pragma once

namespace star_map
{
enum class System {
    AlphaCentauri,
    BetaHydri,
    DeltaEridani,
    EpsilonEridani,
    Omicron2Eridani,
    Sol
};    
}

namespace heaven
{

class Vessel {
public:
    Vessel(std::string name, int generation, star_map::System system = star_map::System::Sol);
    Vessel replicate(std::string name);
    void make_buster();
    bool shoot_buster();
    std::string name;
    star_map::System current_system;
    int generation;
    int busters;
};

std::string get_older_bob(Vessel v1, Vessel v2);
bool in_the_same_system(Vessel v1, Vessel v2);

}
