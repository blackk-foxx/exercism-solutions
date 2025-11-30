#include "pangram.h"
#include <set>

namespace pangram {

constexpr auto alphabet_length = 26;
    
bool is_pangram(const std::string& sentence) {
    std::set<char> letters;
    for (auto c: sentence)
        if (isalpha(c))
            letters.insert(tolower(c));
    return letters.size() == alphabet_length;
}

}  // namespace pangram
