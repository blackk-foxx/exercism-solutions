#include "atbash_cipher.h"
#include <algorithm>
#include <sstream>

char encode_char(char c) {
    if (isalpha(c))
        return 'z' - (c - 'a');
    return c;
}

template<typename T> std::string intersperse(std::string_view text, T spacer, size_t interval) {
    std::ostringstream result;
    size_t i;
    for (i = 0; i + interval < text.size(); i += interval)
        result << text.substr(i, interval) << spacer;
    result << text.substr(i, interval);
    return result.str();
}

std::string chunked(std::string_view text) {
    return intersperse(text, ' ', 5);
}

std::string encoded(std::string_view text) {
    std::string result(text.size(), ' ');
    std::transform(
        text.cbegin(), text.cend(), result.begin(), [](char c) {return encode_char(tolower(c));}
    );
    return result;
}

std::string alphanumeric_only(std::string_view text) {
    std::string result;
    std::copy_if(text.begin(), text.end(), std::back_inserter(result), ::isalnum);
    return result;    
}

std::string unspaced(std::string_view text) {
    std::string result;
    std::copy_if(
        text.begin(), text.end(), std::back_inserter(result), [](char c){return !isspace(c);}
    );
    return result;
}

namespace atbash_cipher {

std::string encode(std::string_view text) {
    return chunked(encoded(alphanumeric_only(text)));
}

std::string decode(std::string_view text) {
    return encoded(unspaced(text));
}

}  // namespace atbash_cipher
