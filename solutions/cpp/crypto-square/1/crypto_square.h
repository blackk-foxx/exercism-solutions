#pragma once
#include <string>

namespace crypto_square {

struct cipher {
    cipher(std::string_view plaintext) : plaintext(plaintext) { }
    std::string normalized_cipher_text();
    std::string_view plaintext;
};

}  // namespace crypto_square
