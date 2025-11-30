#pragma once

namespace triangle {

enum class flavor {
    equilateral,
    isosceles,
    scalene
};

flavor kind(float a, float b, float c);

}  // namespace triangle
