#include "beer_song.h"

namespace beer_song {

std::string sing(int begin, int end) {
    std::string result;
    for (auto v = begin; v > end; --v)
        result += verse(v) + "\n";
    result += verse(end);
    return result;
}

std::string subject(int n) {
    std::string number = n > 0 ? std::to_string(n) : "no more";
    std::string noun = std::string("bottle") + (n == 1 ? "" : "s");
    return number + " " + noun + " of beer";
}

std::string capitalize(std::string s) {
    return std::string(1, std::toupper(s[0])) + s.substr(1);
}

std::string verse(int n) {
    constexpr auto location = " on the wall";
    constexpr auto phrase_end = ".\n";
    constexpr auto separator = ", ";
    std::string pronoun = n > 1 ? "one" : "it";
    std::string next_step = n > 0 
        ? "Take " + pronoun + " down and pass it around"
        : "Go to the store and buy some more";
    int remaining = (n - 1) >= 0 ? n - 1 : 99;
    std::string precondition = capitalize(subject(n)) + location + separator + subject(n);
    std::string outcome = subject(remaining) + location;
    return precondition + phrase_end + next_step + separator + outcome + phrase_end;
}

}  // namespace beer_song
