#include "reverse_string.h"
#include <deque>

namespace reverse_string {

std::string reverse_string(const std::string& s) {
    std::deque<char> deque;
    std::copy(s.begin(), s.end(), std::front_inserter(deque));
    std::string result(deque.begin(), deque.end());
    return result;
}

}  // namespace reverse_string
