#include "pangram.h"
#include <set>

namespace pangram {

bool is_pangram(const std::string& sentence) {
    std::set<char> letters;
    for (auto c: sentence)
        if (isalpha(c))
            letters.insert(tolower(c));
    return letters.size() == 26;
}

}  // namespace pangram
