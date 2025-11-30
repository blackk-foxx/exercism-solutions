#include "raindrops.h"
#include <sstream>
#include <vector>

namespace raindrops {

const std::vector<std::pair<int, std::string>> divisor_sound_pairs {
    {3, "Pling"},
    {5, "Plang"},
    {7, "Plong"}
};

std::string convert(unsigned int number) {
    std::ostringstream result;
    for (auto [divisor, sound]: divisor_sound_pairs)
        if (number % divisor == 0)
            result << sound;
    if (result.str().empty())
        result << number;
    return result.str();
}

}  // namespace raindrops
