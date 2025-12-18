#pragma once
#include <array>
#include <string>

namespace kindergarten_garden {

    enum class Plants: char {
        clover = 'C',
        grass = 'G',
        radishes = 'R',
        violets = 'V'
    };

    std::array<Plants, 4> plants(const std::string& garden, const std::string& student);

}  // namespace kindergarten_garden
