#include "kindergarten_garden.h"

#include <sstream>
#include <unordered_map>

namespace kindergarten_garden {

    std::unordered_map<std::string, size_t> index_for_student = {
        {"Alice", 0},
        {"Bob", 1},
        {"Charlie", 2},
        {"David", 3},
        {"Eve", 4},
        {"Fred", 5},
        {"Ginny", 6},
        {"Harriet", 7},
        {"Ileana", 8},
        {"Joseph", 9},
        {"Kincaid", 10},
        {"Larry", 11}
    };

    std::array<Plants, 4> plants(const std::string& garden, const std::string& student)
    {
        std::array<Plants, 4> result;
        auto second_row_offset = garden.find('\n') + 1;
        auto student_offset = index_for_student[student] * 2;
        for (size_t r = 0; r < 2; ++r)
            for (size_t c = 0; c < 2; ++c) {
                auto plant_index = r * second_row_offset + student_offset + c;
                result[r * 2 + c] = static_cast<Plants>(garden[plant_index]);
            }
        return result;
    }
}  // namespace kindergarten_garden
