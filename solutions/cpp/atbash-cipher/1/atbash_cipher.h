#pragma once
#include <string>

namespace atbash_cipher {

std::string encode(std::string_view text);
std::string decode(std::string_view cipher);

}  // namespace atbash_cipher
