#include "doctor_data.h"

using namespace heaven;

Vessel::Vessel(
    std::string name, int generation, star_map::System system
)//: name(name), generation(generation), current_system(system), busters(0)
{
    this->name = name;
    this->generation = generation;
    current_system = system;
    busters = 0;
}

Vessel Vessel::replicate(std::string name) {
    Vessel result(name, generation + 1, current_system);
    return result;
}


void Vessel::make_buster() {
    busters++;    
}

bool Vessel::shoot_buster() {
    if (busters > 0) {
        busters--;
        return true;
    }
    return false;
}

bool heaven::in_the_same_system(Vessel v1, Vessel v2) {
    return v1.current_system == v2.current_system;
}

std::string heaven::get_older_bob(Vessel v1, Vessel v2) {
    if (v1.generation < v2.generation)
        return v1.name;
    return v2.name;
}
