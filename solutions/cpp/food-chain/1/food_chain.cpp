#include "food_chain.h"
#include <array>
#include <sstream>

const std::array<std::string_view, 8> animal = {
    "fly",
    "spider",
    "bird",
    "cat",
    "dog",
    "goat",
    "cow",
    "horse",
};

const std::array<std::string, 8> comment = {
    "",
    "It wriggled and jiggled and tickled inside her.\n",
    "How absurd to swallow a bird!\n",
    "Imagine that, to swallow a cat!\n",
    "What a hog, to swallow a dog!\n",
    "Just opened her throat and swallowed a goat!\n",
    "I don't know how she swallowed a cow!\n",
    "She's dead, of course!\n",
};

std::string tagline(std::string_view predator, std::string_view prey) {
    std::stringstream result;
    result << "She swallowed the " << predator << " to catch the " << prey;
    return result.str();
}

std::string opener(std::string_view animal) {
    std::stringstream result;
    result << "I know an old lady who swallowed a " << animal << ".\n";
    return result.str();
}

std::string tag(size_t n) {
    if (n > 0) {
        const auto predator = animal[n];
        const auto prey = animal[n - 1];
        const auto ending = 
            prey == "spider" ? " that wriggled and jiggled and tickled inside her" : "";
        return tagline(predator, prey) + ending + ".\n" + tag(n - 1);
    }
    return         
        "I don't know why she swallowed the fly. "
        "Perhaps she'll die.\n";

}

namespace food_chain {

std::string verse(size_t n) {
    auto i = std::min(n - 1, animal.size() - 1);
    if (i == animal.size() - 1)
        return opener(animal[i]) + comment[i];
    return opener(animal[i]) + comment[i] + tag(i);
}

std::string verses(size_t begin, size_t end) {
    std::string result;
    for (auto n = begin; n <= end; n++)
        result += verse(n) + "\n";
    return result;
}

std::string sing() {
    return verses(1, 8);    
}

}  // namespace food_chain
