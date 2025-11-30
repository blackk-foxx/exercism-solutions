#include "crypto_square.h"
#include <cmath>
#include <iostream>
#include <tuple>
#include <vector>
#include <boost/algorithm/string/join.hpp>


std::tuple<unsigned, unsigned> find_rectangle_for_area(unsigned area) {
    auto root = std::sqrt(area);
    unsigned root_floor = std::floor(root);
    if (std::floor(root) == root)
        return std::make_tuple(root_floor, root_floor);
    else if (std::round(root) == root_floor)
        return std::make_tuple(root_floor, root_floor + 1);
    else
        return std::make_tuple(root_floor + 1, root_floor + 1);
} 

std::string normalize(std::string_view text) {
    std::string result;
    for (auto c: text) {
        if (::isalpha(c) || ::isdigit(c))
            result.push_back(::tolower(c));
    }
    return result;
}

std::string arrange_by_columns(std::string_view text, unsigned height, unsigned width) {
    std::string result;
    for (size_t c = 0; c < width; c++) {
        for (size_t r = 0; r < height; r++)
            result.push_back(text[r * width + c]);
        result.push_back(' ');
    }
    if (!result.empty())
        result.pop_back();
    return result;
}

namespace crypto_square {

std::string cipher::normalized_cipher_text() {
    std::string normalized_plaintext = normalize(plaintext);
    auto [height, width] = find_rectangle_for_area(normalized_plaintext.size());
    auto pad_size = height * width - normalized_plaintext.size();
    normalized_plaintext += std::string(pad_size, ' ');
    return arrange_by_columns(normalized_plaintext, height, width);
}

}  // namespace crypto_square

