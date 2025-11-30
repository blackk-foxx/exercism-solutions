#include "word_count.h"
#include <regex>

std::string normalize(const std::string& word) {
    std::string filtered, result;
    std::transform(word.cbegin(), word.cend(), std::back_inserter(result), ::tolower);
    return result;
}

namespace word_count {

std::map<std::string, int> words(std::string sentence) {
    std::map<std::string, int> result;
    std::regex word_pattern("[\\w\\d]+('[\\w\\d]+)?");
    std::sregex_iterator match(sentence.cbegin(), sentence.cend(), word_pattern), match_end;
    for (; match != match_end; ++match)
        result[normalize(match->str())]++;
    return result;
}

}  // namespace word_count
