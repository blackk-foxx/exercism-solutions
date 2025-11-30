#include "bob.h"
#include <algorithm>

template<typename T> std::string filter(std::string_view s, T pred) {
    std::string result;
    std::copy_if(s.begin(), s.end(), std::back_inserter(result), pred);
    return result;
}

std::string remove_spaces(std::string_view s) {
    return filter(s, [] (auto c) {return !isspace(c);});
}

bool is_shouting(std::string_view prompt) {
    const std::string prompt_alpha = filter(prompt, ::isalpha);
    if (prompt_alpha.size() == 0) return false;
    return std::all_of(prompt_alpha.begin(), prompt_alpha.end(), ::isupper);
}

bool is_question(std::string_view prompt) {
    return remove_spaces(prompt).back() == '?';
}

bool is_silence(std::string_view prompt) {
    return std::all_of(prompt.begin(), prompt.end(), ::isspace);
}

namespace bob {

std::string hey(std::string_view prompt) {
    if (is_shouting(prompt) && is_question(prompt))
        return "Calm down, I know what I'm doing!";
    if (is_shouting(prompt))
        return "Whoa, chill out!";
    if (is_question(prompt))
        return "Sure.";
    if (is_silence(prompt))
        return "Fine. Be that way!";
    return "Whatever.";
}

}  // namespace bob
